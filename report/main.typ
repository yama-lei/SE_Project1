#let student-id = sys.inputs.at("student-id", default: "待填写学号")
#let student-name = sys.inputs.at("student-name", default: "待填写姓名")

#let repo-url = sys.inputs.at("repo-url", default: "待填写仓库地址")
#let branch = sys.inputs.at("branch", default: "待填写分支")
#let draft-hash = sys.inputs.at("draft-hash", default: "待填写 lab1-ai-draft 提交哈希")
#let final-hash = sys.inputs.at("final-hash", default: "待填写 lab1-final 提交哈希")

#let project = sys.inputs.at("project", default: "多人共享记账系统")
#let partner-name = sys.inputs.at("partner-name", default: "待填写甲方姓名")
#let partner-id = sys.inputs.at("partner-id", default: "待填写甲方学号")
#let report-date = sys.inputs.at("report-date", default: "待填写报告日期")

#set document(title: "实验一：需求分析与 AI 结果审查", author: student-name)
#set text(font: ("Noto Serif CJK SC", "SimSun"), size: 10.5pt, lang: "zh")
#set par(justify: true, leading: 0.65em)
#set page(
  paper: "a4",
  margin: (x: 2.4cm, y: 2.2cm),
  header: align(right, text(size: 9pt, fill: gray)[软件工程 · 实验一]),
  numbering: "1",
)
#set heading(numbering: "1.1")
#set table(inset: 7pt, stroke: 0.5pt + luma(180))
#show heading.where(level: 1): set text(size: 15pt)
#show heading.where(level: 2): set text(size: 12pt)

#align(center)[
  #v(1cm)
  #text(size: 23pt, weight: "bold")[需求分析与 AI 结果审查]
  #v(0.5cm)
  #text(size: 15pt)[实验一报告]
  #v(1cm)
  项目：#project \
  学号：#student-id \
  姓名：#student-name \
  甲方：#partner-name（#partner-id） \
  日期：#report-date
  #v(0.8cm)
]


#outline(title: [目录], depth: 2)
#pagebreak()

= 项目背景、目标与系统边界

== 背景与目标

实现一个功能完全的记账系统

== 范围与明确不实现的内容
- 范围内：待填写，引用相关 REQ 编号与访谈来源。
- 范围外：待填写，明确真实支付、物流、第三方服务等是否不要求实现。
- 依据：待填写，使用 INT-01-L023 等来源编号；未确认内容标为假设或待确认。

= 用户角色及权限

至少列出三类权限不同的角色，并说明数据访问范围及禁止操作。
#table(
  columns: (1fr, 2fr, 2fr, 1.5fr),
  table.header([*角色*], [*允许操作及数据范围*], [*禁止操作*], [*需求与来源*]),
  [待填写角色一], [待填写], [待填写], [待填写],
  [待填写角色二], [待填写], [待填写], [待填写],
  [待填写角色三], [待填写], [待填写], [待填写],
)

= 主要业务流程与核心数据

== 正常流程与异常分支
待填写：按“角色 → 前置条件 → 操作 → 状态及数据变化 → 结果”描述主要流程，
并列出失败、撤销、超时等分支及对应需求编号。可插入自行绘制的流程图。

== 数据对象与关系
#table(
  columns: (1fr, 2fr, 2fr),
  table.header([*对象*], [*关键属性与唯一约束*], [*关系与一致性规则*]),
  [待填写], [待填写：标识、持久化数据、唯一性], [待填写：关系基数、更新约束],
)
待填写：多条件查询、统计口径，以及关键操作记录的内容、可见范围与保留规则。

= 核心业务对象状态及转换

核心对象：待填写。至少列出四个有效状态，明确初始状态、终止状态和各状态含义。
#table(
  columns: (1fr, 1.5fr, 1fr, 2fr),
  table.header([*当前状态*], [*触发操作／角色*], [*目标状态*], [*条件与副作用*]),
  [待填写状态一], [待填写], [待填写状态二], [待填写],
  [待填写状态二], [待填写], [待填写状态三], [待填写],
  [待填写状态三], [待填写], [待填写状态四], [待填写],
)
- 禁止的转换及处理结果：待填写。
- 重复操作、并发竞争、超时或旧状态冲突：待填写至少两类场景，说明原子性、幂等性或恢复规则。

= 需求与验收方法总结

== 功能需求
待填写：按业务能力汇总至少 10 条已确认功能需求，引用稳定的 REQ 编号，不必粘贴完整需求。
#table(
  columns: (1fr, 2fr, 2.5fr),
  table.header([*需求编号*], [*目标与来源*], [*可观察的验收方法*]),
  [待填写], [待填写], [待填写：输入、操作、预期结果],
)

== 非功能需求
待填写：总结至少 3 条已确认非功能需求，说明测量对象、条件、阈值及失败判定。
#table(
  columns: (1fr, 2fr, 2.5fr),
  table.header([*需求编号*], [*条件与判断标准*], [*验证方式*]),
  [待填写], [待填写], [待填写],
)

== 完整性核对
待填写：确认已确认需求总数不少于 15 条；至少 5 条明确异常、边界或冲突处理。
给出对应需求编号，并核对权限、状态、数据、查询统计、操作记录及可验证的质量要求。

= 歧义、冲突、假设及处理结果

#table(
  columns: (1.5fr, 1.5fr, 2fr, 1fr),
  table.header([*问题与影响*], [*原始依据*], [*澄清与处理结果*], [*状态*]),
  [待填写], [待填写来源编号], [待填写补充沟通及关联 REQ], [待确认],
)
待填写：未解决问题、负责人和确认计划。不得将待确认内容计为已确认需求。

= AI 使用、审查与反思

== 使用过程
待填写：工具和模型名称、使用时间、输入材料、初稿生成及人工复核过程。
完整提示词、模型首次输出与后续交互保存在 chat.txt 的对应分段。

== 代表性审查
至少总结三个有实质依据的审查结果，与 chat.txt 的 REV 编号和 Git diff 对应。
#table(
  columns: (1fr, 1.5fr, 2fr, 1.5fr),
  table.header([*审查编号*], [*AI 原稿问题*], [*核对依据与修改*], [*关联需求*]),
  [REV-001], [待填写], [待填写], [待填写],
  [REV-002], [待填写], [待填写], [待填写],
  [REV-003], [待填写], [待填写], [待填写],
)

== 反思
待填写：AI 带来的帮助、容易产生的遗漏或无依据推断、人工审查方法及仍存在的局限。

= 最终需求基线说明

仓库地址：#repo-url \
分支名称：#branch \
lab1-ai-draft：#raw(draft-hash) \
lab1-final：#raw(final-hash)


最终需求以 lab1-final 中的 requirements.md 为准，访谈、完整 AI 交互及审查记录见同一标签中的 chat.txt。
报告在两个标签固定后依据最终需求编写，不要求属于 lab1-final 提交。
提交脚本只读取标签，不创建、移动或推送标签。
