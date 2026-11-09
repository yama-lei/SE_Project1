#import "../nju-lab.typ": *

// ---------- 主题样式（南大紫，见 nju-lab.typ） ----------
#let accent = nju-purple
#let accent-dark = nju-purple-dark
#let accent-light = nju-purple-light
#let accent-mid = nju-purple-mid

// 需求编号徽章
#let req(id) = id
// 来源编号
#let src(id) = text(size: 0.82em, fill: luma(105), font: nju-fonts.hei)[#id]

#let mytable = nju-table

#show: nju-lab.with(
  title: "需求分析报告",
  subtitle: "软件设计与建模",
  course: "软件工程 · 实验二",
  author: "雷业成",
  info: (
    "项目名称": "南雍记账",
    "学号": "241220106",
    "日期": "2026-11-31",
  ),
)

= 软件功能

// TODO：按模块列出主要功能，可对应需求编号（#req("REQ-xxx")）。

#mytable(
  columns: (1fr, 3fr, 1.5fr),
  table.header([#hcell[模块]], [#hcell[主要功能]], [#hcell[需求]]),
  [账号], [TODO], [TODO],
  [账本与成员], [TODO], [TODO],
  [收支记录], [TODO], [TODO],
  [截图导入], [TODO], [TODO],
  [查询统计], [TODO], [TODO],
  [预算], [TODO], [TODO],
  [结算], [TODO], [TODO],
  [储钱目标], [TODO], [TODO],
  [操作记录与通知], [TODO], [TODO],
)

= 软件架构UML

== 组件图（结构性图）

// TODO：说明模块划分、模块间依赖，以及这样设计的原因。
#figure(
  image("uml/component.svg", width: 100%),
  caption: [软件模块划分（组件图）],
) <fig:component>

== 类图（结构性图）

// TODO：说明核心类、关联与多重性，数据存储形式。
#figure(
  image("uml/class.svg", width: 100%),
  caption: [核心类图],
) <fig:class>

== 状态图（行为性图）

// TODO：说明收支记录五个状态及转换条件。
#figure(
  image("uml/state.svg", width: 72%),
  caption: [收支记录状态图],
) <fig:state>

== 顺序图（交互性图）

// TODO：说明结算时各模块的交互顺序。
#figure(
  image("uml/sequence.svg", width: 90%),
  caption: [结算顺序图],
) <fig:sequence>

== 设计原因

// TODO：分层、权限与审计横切、事务与幂等等设计取舍。

= UI界面

// TODO：每个功能模块一张 UI 图 + 功能说明。

== 移动端 UI 设计：AI初版

AI初版

#figure(
  grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 8pt,
    image("ui/v1/01-home.png"),
    image("ui/v1/02-records.png"),
    image("ui/v1/03-add.png"),
    image("ui/v1/04-settle.png"),
    image("ui/v1/05-me.png"),
  ),
  caption: [移动端 UI（AI初版）：账本首页、收支记录、记一笔、结算、我的],
) <fig:ui-v1>

== 移动端 UI 设计：AI+人工多轮更改

AI+人工多轮更改

#figure(
  grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 8pt,
    image("ui/v2/01-home.png"),
    image("ui/v2/02-records.png"),
    image("ui/v2/03-add.png"),
    image("ui/v2/04-settle.png"),
    image("ui/v2/05-me.png"),
    image("ui/v2/06-members.png"),
  ),
  caption: [移动端 UI（AI+人工多轮更改）：概览、账单、记一笔、结算、我的、成员管理],
) <fig:ui-v2>

== 登录与注册

== 账本列表与成员管理

== 记录录入与截图导入

== 查询统计与预算

== 结算与储钱目标

== 操作记录与通知

= AI Use statement
在本次实验中，报告里面的每一个字都是我自己敲的，没有使用AIGC生成文本的情况。
其中UI使用[Pencil](https://github.com/evolus/pencil)生成并做手工调整，以符合最后的预期。

UML图也是先让AI生成初稿，之后分别使用