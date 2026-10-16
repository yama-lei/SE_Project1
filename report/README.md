# 实验一报告与打包

在仓库根目录创建或补充 `.env`，字段见 `.env.example`：

```bash
STUID=你的学号
STUNAME='你的姓名'
PARTNER_NAME='甲方姓名'
PARTNER_ID=甲方学号
PROJECT_NAME='多人共享记账系统'
# REPORT_DATE=2026-10-16
```

- 前四项必填；学号、姓名同时用于报告封面和压缩包命名。
- 项目名称可选，默认“多人共享记账系统”；报告日期可选，默认运行当天。
- `REPO_URL` 可选，未设置时使用 Git 的 `origin`；分支和标签哈希由脚本读取。
- `.env` 是通过 Bash `source` 加载的可信本机配置，含空格或特殊字符的值须正确加引号；不要加载他人提供的文件，也不要提交真实 `.env`。
- 也可直接通过进程环境变量提供这些字段；若存在 `.env`，其中赋值优先。

填写 `report/main.typ` 的报告正文后，运行：

```bash
bash submit.sh
```

脚本将环境配置通过 Typst 的 `--input` 传入报告，不改写模板中的个人信息。输出为 `report/request.pdf` 和 `dist/实验1_学号_姓名.zip`。

打包需要 `git`、`typst`、`zip`、`cmp`，并要求已有不同提交上的 `lab1-ai-draft` 与 `lab1-final` 标签，且工作区 `requirements.md`、`chat.txt` 与最终标签逐字节一致。脚本不创建、移动或推送标签。

个人信息配置不替代报告正文；提交前仍须按 TASK 核对内容及两个标签的完整提交哈希。

测试：`python3 -m unittest discover -s tests -v`（在临时仓库中运行，不修改真实作业标签）。
