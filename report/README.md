# 实验报告

报告按任务分别存放：

- [task1](task1/README.md)：实验一需求分析报告，现有报告及 UML 图已归入此目录。
- [task2](task2/README.md)：实验二报告，待编写。
- [task3](task3/README.md)：实验三报告，待编写。

`nju-lab.typ` 是三个任务共用的 Typst 模板，校徽、校名等共享素材位于 `assets/`。各任务的报告入口使用 `main.typ`，在文件中通过 `#import "../nju-lab.typ": *` 引入模板。

在仓库根目录预览实验一报告：

```bash
typst compile --root . report/task1/main.typ report/task1/request.pdf
```

`bash submit.sh` 目前仅打包实验一，配置、输出及测试说明见 [task1 报告说明](task1/README.md)。
