#let student-id = sys.inputs.at("student-id", default: "待填写学号")
#let student-name = sys.inputs.at("student-name", default: "待填写姓名")

#let repo-url = sys.inputs.at("repo-url", default: "待填写仓库地址")
#let branch = sys.inputs.at("branch", default: "待填写分支")
#let draft-hash = sys.inputs.at("draft-hash", default: "待填写 lab1-ai-draft 提交哈希")
#let final-hash = sys.inputs.at("final-hash", default: "待填写 lab1-final 提交哈希")

#let project = sys.inputs.at("project", default: "多人共享记账系统")
#let partner-name = sys.inputs.at("partner-name", default: "")
#let partner-id = sys.inputs.at("partner-id", default: "")
#let report-date = sys.inputs.at("report-date", default: "2026年10月15日")
#let report-version = sys.inputs.at("report-version", default: "待填写")

#set document(title: "需求分析报告", author: student-name)
#set text(font: ("Liberation Sans", "Noto Sans CJK SC"), size: 10.5pt, lang: "zh")
#set par(justify: true, leading: 0.65em, spacing: 0.8em)
#set page(paper: "a4", margin: (x: 2.2cm, y: 1.8cm))
#set heading(numbering: "1.1")
#show heading.where(level: 1): it => block(above: 1.1em, below: 0.65em, sticky: true)[
  #line(length: 100%, stroke: 0.4pt + luma(200))
  #v(0.25em)
  #text(size: 15pt, weight: "bold")[#numbering("1.", ..counter(heading).get()) #it.body]
]
#show heading.where(level: 2): it => block(above: 0.9em, below: 0.6em, sticky: true)[
  #text(size: 12pt, weight: "bold")[#numbering("1.1", ..counter(heading).get()) #it.body]
]

#text(size: 20pt, weight: "bold")[需求分析报告]
#v(0.15em)
#line(length: 100%, stroke: 0.4pt + luma(200))

项目名称：#project

版本：#report-version #h(1em) 日期：#report-date #h(1em) 学号、姓名：#student-id、#student-name

甲方：#partner-name（#partner-id）

#text(size: 9.5pt)[本模板按本人访谈补充内容，提交前删除填写提示。完整需求以 requirements.md 为准。]

= 背景概述

实现一个功能完全的记账系统

[待填写：说明项目服务对象、要解决的问题和目标，明确系统边界及不实现的内容。
范围引用实际 REQ 编号及 INT 来源编号，未确认内容标为假设或待确认。]

= 需求分析

== 用户角色与业务模块

[待填写：至少三类权限不同的角色，分别说明允许操作、数据可见范围及禁止操作。
按账本与成员、收支记录与审核、查询统计、预算结算等模块概括已确认功能需求。
引用至少 10 条功能需求的实际 ID，不必重复完整条目。]

*需求 ID：* [待填写实际 REQ 编号]

*需求描述：* [待填写该需求的主要目标、角色及适用条件。]

*分析：* [待填写权限、异常或冲突规则、来源编号和可观察的验收方法。
其余功能按模块概括，完整字段参见 requirements.md。]

== 核心流程、数据与状态

[待填写：按“角色 → 前置条件 → 操作 → 状态及数据变化 → 结果”概括主要流程。
说明失败、撤销等分支，列出核心数据对象、持久化属性、唯一性约束、对象关系及一致性规则。]

[待填写：选定一个核心业务对象，列出至少四个有效状态及其含义，明确初始状态、终止状态、允许与禁止的转换。
至少覆盖两类重复操作、并发竞争、超时或状态冲突，并说明处理结果。
补充多条件查询、统计口径及关键操作记录的内容、可见范围与保留规则，引用相关 REQ 编号。]

= 非功能性需求

[待填写：概括至少 3 条已确认非功能需求，分别引用实际 REQ 编号。
每条说明测量对象、测试环境、数据规模或负载、判断阈值和验证方式，明确失败与超时的判定。
安全、可靠性或易用性要求同样须可验证，不能只写“快速”“安全”“稳定”。]

#pagebreak()

= 结论

[待填写：总结已确认的业务范围及其对后续设计、实现和测试的支持。
填写已确认需求总数、功能需求数、非功能需求数及验收情况。
核对总数不少于 15 条、功能不少于 10 条、非功能不少于 3 条，
至少 5 条明确异常、边界或冲突处理，并列出对应需求编号。待确认内容不计入已确认需求。]

== 歧义、冲突与 AI 审查

*歧义与处理：* [待填写访谈中的歧义、冲突和假设，引用原始来源及补充沟通编号，
说明处理结果和关联 REQ。未解决问题标为待确认，并注明负责人及确认计划。]

*AI 使用过程：* [待填写工具与模型名称、使用时间、输入材料、初稿生成及人工复核过程。
完整提示词、模型首次输出和后续交互见 chat.txt 对应分段。]

*REV-001：* [待填写 AI 原稿问题、核对依据、实质修改及关联需求，与 chat.txt 和 Git diff 对应。]

*REV-002：* [待填写 AI 原稿问题、核对依据、实质修改及关联需求，与 chat.txt 和 Git diff 对应。]

*REV-003：* [待填写 AI 原稿问题、核对依据、实质修改及关联需求，与 chat.txt 和 Git diff 对应。]

*反思：* [待填写 AI 带来的帮助、遗漏或无依据推断、人工审查方法及仍存在的局限。
正确内容可以保留，不为制造 diff 而修改。]

== 最终需求基线说明

仓库地址：#repo-url

分支名称：#branch

lab1-ai-draft 完整提交哈希：#raw(draft-hash)

lab1-final 完整提交哈希：#raw(final-hash)

固定标签后填写上述信息并导出报告。最终需求以 lab1-final 中的 requirements.md 为准，
提交的 requirements.md 和 chat.txt 须与该标签中的同名文件逐字节一致。
报告依据最终需求编写，不要求属于 lab1-final 提交。

#block(above: 1.1em, below: 0.65em, sticky: true)[
  #line(length: 100%, stroke: 0.4pt + luma(200))
  #v(0.25em)
  #text(size: 15pt, weight: "bold")[附：需求整理与会谈内容]
]

[待填写：按业务模块概括需求，可引用少量关键会谈，保留真实来源编号与沟通时间。
完整正式访谈、补充沟通、模型输入、初稿、后续交互及审查记录保存在 chat.txt，报告不必重复粘贴全文。]

甲方（[实际 INT 来源编号与时间]）：[待填写关键原话。]

乙方（[实际 INT 来源编号与时间]）：[待填写澄清问题。]

甲方（[实际 INT 来源编号与时间]）：[待填写补充确认及关联 REQ 编号。]

#text(size: 9.5pt)[正式提交仍须满足 TASK.md 的全部数量与内容要求。压缩包仅含 request.pdf、requirements.md 和 chat.txt。
提交脚本只读取标签，不创建、移动或推送标签。]
