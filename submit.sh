#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
root=$PWD
fail() { printf '错误：%s\n' "$*" >&2; exit 1; }

# .env 是本机可信的 Bash 配置，不应加载他人提供的文件。
if [[ -f .env ]]; then
  source .env
fi
for tool in git typst zip cmp; do
  command -v "$tool" >/dev/null || fail "缺少命令 $tool，请安装后重试。"
done
for key in STUID STUNAME PARTNER_NAME PARTNER_ID; do
  value=${!key:-}
  [[ -n "$value" && "$value" != *[[:cntrl:]/\\]* ]] || fail "$key 不能为空或包含路径分隔符、控制字符。"
  [[ "$value" != *xxxxx* && "$value" != leixxx && "$value" != 待填写* ]] || fail "请在 .env 中填写真实的 $key。"
done

repo_url=${REPO_URL:-$(git remote get-url origin 2>/dev/null || true)}
[[ -n "$repo_url" ]] || fail "请设置 origin 远程地址或在 .env 中填写 REPO_URL。"
# 将常见的 SSH 克隆地址转换为报告中可访问的 HTTPS 地址。
if [[ "$repo_url" == git@*:* ]]; then
  host_path=${repo_url#git@}
  repo_url="https://${host_path/:/\/}"
fi
repo_url=${repo_url%.git}
branch=$(git symbolic-ref --quiet --short HEAD) || fail "当前处于 detached HEAD，请切换到提交分支。"
draft_hash=$(git rev-parse --verify 'refs/tags/lab1-ai-draft^{commit}' 2>/dev/null) || fail "缺少 lab1-ai-draft 标签。"
final_hash=$(git rev-parse --verify 'refs/tags/lab1-final^{commit}' 2>/dev/null) || fail "缺少 lab1-final 标签。"
[[ "$draft_hash" != "$final_hash" ]] || fail "两个标签必须对应两个可比较的提交。"
git merge-base --is-ancestor "$draft_hash" "$final_hash" || fail "lab1-ai-draft 必须是 lab1-final 的祖先。"
git merge-base --is-ancestor "$final_hash" HEAD || fail "当前分支不包含 lab1-final。"

mkdir -p dist
stage=$(mktemp -d "$root/dist/.submit.XXXXXX")
trap 'rm -rf -- "$stage"' EXIT
name="实验1_${STUID}_${STUNAME}"
package="$stage/$name"
mkdir -- "$package"
for file in requirements.md chat.txt; do
  [[ -s "$file" ]] || fail "$file 不存在或为空。"
  git show "$final_hash:$file" > "$package/$file" || fail "lab1-final 中缺少 $file。"
  cmp -s -- "$file" "$package/$file" || fail "$file 与 lab1-final 不一致，请核对最终基线；脚本不会修改标签。"
done

typst compile --root "$root" \
  --input "student-id=$STUID" --input "student-name=$STUNAME" \
  --input "partner-name=$PARTNER_NAME" --input "partner-id=$PARTNER_ID" \
  --input "project=${PROJECT_NAME:-多人共享记账系统}" \
  --input "report-date=${REPORT_DATE:-$(date +%F)}" \
  --input "repo-url=$repo_url" --input "branch=$branch" \
  --input "draft-hash=$draft_hash" --input "final-hash=$final_hash" \
  report/main.typ "$package/request.pdf"
(
  cd -- "$stage"
  zip -q -r "$name.zip" "$name"
)
# 每次从干净的临时目录打包，避免 zip 更新模式混入旧文件。
cp -- "$package/request.pdf" report/request.pdf
mv -f -- "$stage/$name.zip" "dist/$name.zip"
printf '已生成：\n  %s/report/request.pdf\n  %s/dist/%s.zip\n' "$root" "$root" "$name"
printf '提交前请人工确认：报告已填完、与最终需求一致，分支及两个标签已推送且仓库可访问。\n'
