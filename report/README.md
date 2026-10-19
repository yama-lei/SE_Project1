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

- 前四项必填；学号、姓名同时用于报告首页和压缩包命名。
- 项目名称可选，默认“多人共享记账系统”；报告日期可选，默认运行当天。
- `REPO_URL` 可选，未设置时使用 Git 的 `origin`；分支和标签哈希由脚本读取。
- `.env` 是通过 Bash `source` 加载的可信本机配置，含空格或特殊字符的值须正确加引号；不要加载他人提供的文件，也不要提交真实 `.env`。
- 也可直接通过进程环境变量提供这些字段；若存在 `.env`，其中赋值优先。

`report/main.typ` 使用 `report/nju-lab.typ`（南大紫配色、校徽页眉，素材在 `report/assets/`，取自 modern-nju-thesis，MIT）并按 `demo/request.pdf` 排版，不设独立封面和目录。正文依次为背景概述、需求分析、非功能性需求、结论，最后附需求整理与会谈内容。保留任务书要求的填写提示，提交前须替换为本人内容，并填写首页的报告版本。

UML 图源文件为 `report/uml/*.puml`，修改后运行 `bash report/uml/build.sh` 重新生成 SVG（需要 Java 和 PlantUML jar，默认路径 `~/.local/share/plantuml/plantuml.jar`，可用 `PLANTUML_JAR` 覆盖；不需要 Graphviz）。生成的 SVG 随仓库提交，编译报告时不需要 PlantUML。

仅预览模板，无需标签或打包配置：

```bash
typst compile --root . report/main.typ report/request.pdf
```

预览默认使用模板中的信息，不读取 `.env`，也不自动填写最终基线。填写 `report/main.typ` 的报告正文后，正式打包运行：

```bash
bash submit.sh
```

脚本将环境配置通过 Typst 的 `--input` 传入报告，不改写模板中的个人信息。输出为 `report/request.pdf` 和 `dist/实验1_学号_姓名.zip`。

打包需要 `git`、`typst`、`zip`、`cmp`，并要求已有不同提交上的 `lab1-ai-draft` 与 `lab1-final` 标签，且工作区 `requirements.md`、`chat.txt` 与最终标签逐字节一致。脚本不创建、移动或推送标签。

个人信息配置不替代报告正文；提交前仍须按 TASK 核对内容及两个标签的完整提交哈希。

测试：`python3 -m unittest discover -s tests -v`（在临时仓库中运行，不修改真实作业标签）。
