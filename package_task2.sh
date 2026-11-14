#!/usr/bin/env bash
set -euo pipefail

# 实验信息
STUDENT_ID="241220106"
STUDENT_NAME="雷业成"
TASK_NAME="实验2"
FOLDER_NAME="${TASK_NAME}_${STUDENT_ID}_${STUDENT_NAME}"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT_DIR"

DIST_DIR="$ROOT_DIR/dist"
STAGING_DIR="$DIST_DIR/$FOLDER_NAME"
ZIP_FILE="$DIST_DIR/${FOLDER_NAME}.zip"

mkdir -p "$DIST_DIR"

echo "=== 1. 编译 Typst 实验报告 PDF ==="
typst compile --root "$ROOT_DIR" "$ROOT_DIR/report/task2/main.typ" "$ROOT_DIR/report/task2/main.pdf"

echo "=== 2. 准备打包目录结构 ($FOLDER_NAME) ==="
rm -rf "$STAGING_DIR" "$ZIP_FILE"
mkdir -p "$STAGING_DIR"

# 1. 复制核心实验报告 PDF（包含中文常规命名与学号姓名命名）
cp "$ROOT_DIR/report/task2/main.pdf" "$STAGING_DIR/实验报告.pdf"
cp "$ROOT_DIR/report/task2/main.pdf" "$STAGING_DIR/${FOLDER_NAME}.pdf"

# 2. 复制 UML 源码与渲染图表（PlantUML）
mkdir -p "$STAGING_DIR/UML"
cp "$ROOT_DIR/report/task2/uml/"*.puml "$STAGING_DIR/UML/"
cp "$ROOT_DIR/report/task2/uml/"*.svg "$STAGING_DIR/UML/"
if [ -f "$ROOT_DIR/report/task2/uml/style.iuml" ]; then
    cp "$ROOT_DIR/report/task2/uml/style.iuml" "$STAGING_DIR/UML/"
fi

# 3. 复制 UI 设计产物（包含 v1 AI 初版与 v2 手调版截图）
mkdir -p "$STAGING_DIR/UI界面"
cp -r "$ROOT_DIR/report/task2/ui/"* "$STAGING_DIR/UI界面/"

# 4. 复制手绘草图与设计对比素材
if [ -d "$ROOT_DIR/assets" ]; then
    mkdir -p "$STAGING_DIR/assets"
    cp -r "$ROOT_DIR/assets/"* "$STAGING_DIR/assets/"
fi

# 5. 复制 Typst 报告源码工程（方便助教查验源文件）
mkdir -p "$STAGING_DIR/源码"
cp "$ROOT_DIR/report/task2/main.typ" "$STAGING_DIR/源码/"
cp "$ROOT_DIR/report/nju-lab.typ" "$STAGING_DIR/源码/"
if [ -d "$ROOT_DIR/report/assets" ]; then
    cp -r "$ROOT_DIR/report/assets" "$STAGING_DIR/源码/"
fi

echo "=== 3. 压缩生成 ${FOLDER_NAME}.zip ==="
cd "$DIST_DIR"
zip -r -q "${FOLDER_NAME}.zip" "$FOLDER_NAME"

# 清理临时 staging 目录（保留 zip 压缩包）
rm -rf "$STAGING_DIR"

echo "=== 打包完成！ ==="
echo "产物路径: $ZIP_FILE"
ls -lh "$ZIP_FILE"
