// 南京大学课程实验报告模板
// 校徽与校名矢量图取自 modern-nju-thesis（MIT License, OrangeX4）

// ---------- 配色：南大紫 ----------
#let nju-purple = rgb("#630460")
#let nju-purple-dark = rgb("#4a0347")
#let nju-purple-light = nju-purple.lighten(93%)
#let nju-purple-mid = nju-purple.lighten(70%)
#let nju-gold = rgb("#b8913a")

// ---------- 字体 ----------
#let nju-fonts = (
  song: ("Times New Roman", "TeX Gyre Termes", "Noto Serif CJK SC", "FZXiaoBiaoSong-B05S"),
  hei: ("Liberation Sans", "Noto Sans CJK SC", "Microsoft YaHei"),
  kai: ("Times New Roman", "KaiTi", "FandolKai"),
  title: ("Times New Roman", "FZXiaoBiaoSong-B05S", "Noto Serif CJK SC"),
)

// ---------- 通用组件 ----------
// 表头文字
#let hcell(c) = text(fill: white, weight: "bold", font: nju-fonts.hei)[#c]

// 紫色表头、隔行浅底的表格
#let nju-table(..args) = table(
  inset: 4.5pt,
  stroke: (x, y) => (
    top: if y == 0 { none } else { 0.4pt + luma(205) },
    bottom: 0.6pt + if y == 0 { nju-purple } else { luma(205) },
    left: none, right: none,
  ),
  fill: (x, y) => if y == 0 { nju-purple } else if calc.rem(y, 2) == 0 { nju-purple-light },
  ..args,
)

// 不编号的一级标题样式（附录、致谢等）
#let nju-section(body) = block(above: 1.4em, below: 0.8em, sticky: true, width: 100%)[
  #set text(font: nju-fonts.hei, size: 15pt, weight: "bold", fill: nju-purple-dark)
  #grid(
    columns: (auto, 1fr),
    column-gutter: 8pt,
    align: horizon,
    body, line(length: 100%, stroke: 0.6pt + nju-purple-mid),
  )
]

// 提示框
#let nju-note(title: "说明", body) = block(
  width: 100%,
  inset: (x: 10pt, y: 8pt),
  fill: nju-purple-light,
  stroke: (left: 2.5pt + nju-purple),
  radius: (right: 3pt),
)[
  #text(font: nju-fonts.hei, weight: "bold", fill: nju-purple)[#title]#h(0.6em)#body
]

// ---------- 首页标题区（不单设封面） ----------
#let nju-title-block(
  title: none,
  subtitle: none,
  course: none,
  kind: "本科生课程实验报告",
  info: (),
) = {
  // 校徽 + 校名 + 报告类型
  grid(
    columns: (auto, auto, 1fr),
    column-gutter: 8pt,
    align: horizon,
    image("assets/nju-emblem-purple.svg", height: 1.45cm),
    image("assets/nju-name-purple.svg", height: 1.05cm),
    align(right, {
      set text(font: nju-fonts.hei, fill: nju-purple)
      text(size: 11pt, weight: "bold", tracking: 0.12em)[#kind]
      linebreak()
      text(size: 7.5pt, fill: nju-purple.lighten(30%), tracking: 0.08em)[NANJING UNIVERSITY · COURSE LAB REPORT]
    }),
  )
  v(0.3em)
  // 双线：粗紫 + 细金
  block(spacing: 0pt, line(length: 100%, stroke: 2.2pt + nju-purple))
  v(2pt)
  block(spacing: 0pt, line(length: 100%, stroke: 0.6pt + nju-gold))

  v(1.1em)
  align(center, {
    if course != none {
      text(font: nju-fonts.hei, size: 10pt, fill: luma(100), tracking: 0.2em)[#course]
      v(0.35em)
    }
    text(font: nju-fonts.title, size: 24pt, weight: "bold", fill: nju-purple-dark, tracking: 0.08em)[#title]
    if subtitle != none {
      v(0.25em)
      text(font: nju-fonts.kai, size: 13pt, fill: luma(70))[#subtitle]
    }
  })
  v(0.8em)

  // 信息卡：标签 / 值 两列交替
  if info.len() > 0 {
    let pairs = info.pairs()
    let cells = pairs.map(((k, v)) => (
      text(font: nju-fonts.hei, size: 9pt, weight: "bold", fill: nju-purple)[#k：],
      text(size: 9.5pt)[#v],
    )).flatten()
    block(
      width: 100%,
      inset: (x: 12pt, y: 9pt),
      fill: nju-purple-light,
      radius: 3pt,
      stroke: 0.5pt + nju-purple-mid,
      grid(
        columns: (auto, 1fr, auto, 1fr),
        column-gutter: (8pt, 16pt, 8pt),
        row-gutter: 7pt,
        align: (right + horizon, left + horizon),
        ..cells,
      ),
    )
  }
  v(0.6em)
}

// ---------- 主模板 ----------
#let nju-lab(
  title: "实验报告",
  subtitle: none,
  course: none,
  author: none,
  kind: "本科生课程实验报告",
  header-left: none,
  info: (:),
  first-line-indent: 0pt,
  body,
) = {
  set document(title: title, author: if author == none { () } else { author })
  set text(font: nju-fonts.song, size: 10.5pt, lang: "zh", region: "cn")
  set par(justify: true, leading: 0.72em, spacing: 0.9em, first-line-indent: first-line-indent)
  set list(indent: 1em, spacing: 0.6em, marker: text(fill: nju-purple)[•])
  set enum(indent: 1em, spacing: 0.6em)
  set heading(numbering: "1.1")
  set figure(gap: 0.9em)
  set figure.caption(separator: [　])
  show figure: set text(font: nju-fonts.hei)
  show figure.caption: set text(size: 8.8pt, font: nju-fonts.kai)
  show figure.caption: it => {
    text(font: nju-fonts.hei, weight: "bold", fill: nju-purple)[#it.supplement #context it.counter.display(it.numbering)]
    it.separator
    it.body
  }
  show table: set text(size: 9.5pt)
  show table: set par(justify: false, first-line-indent: 0pt)
  show strong: set text(font: nju-fonts.hei)
  // raw 内置规则会把字号缩到 0.8em，这里放大回约 0.95em，并与正文基线对齐
  show raw: set text(font: ("DejaVu Sans Mono", "Noto Sans CJK SC"), size: 1.18em)
  show raw.where(block: false): it => box(
    fill: nju-purple-light, inset: (x: 2.5pt), outset: (y: 2.5pt), radius: 2pt, it,
  )
  // 中文弯引号用 CJK 字体，避免西文字体的窄引号
  show regex("[“”‘’]"): set text(font: ("Noto Serif CJK SC",))
  show link: set text(fill: nju-purple)

  set page(
    paper: "a4",
    margin: (x: 2.3cm, top: 2.4cm, bottom: 2.2cm),
    // 首页无页眉，其余页：左校名小标 + 课程，右报告标题
    header: context if here().page() > 1 {
      set text(font: nju-fonts.hei, size: 8pt, fill: nju-purple)
      grid(
        columns: (auto, 1fr, auto),
        column-gutter: 6pt,
        align: horizon,
        image("assets/nju-emblem-purple.svg", height: 0.5cm),
        if header-left != none { header-left } else if course != none { course },
        title,
      )
      v(-0.35em)
      line(length: 100%, stroke: 0.5pt + nju-purple-mid)
    },
    footer: context {
      set text(font: nju-fonts.hei, size: 8.5pt, fill: nju-purple)
      let n = counter(page).get().first()
      let total = counter(page).final().first()
      align(center)[
        #box(line(length: 2.5em, stroke: 0.4pt + nju-purple-mid), baseline: -0.3em)
        #h(0.6em)#str(n)#text(fill: luma(140))[ \/ #str(total)]#h(0.6em)
        #box(line(length: 2.5em, stroke: 0.4pt + nju-purple-mid), baseline: -0.3em)
      ]
    },
    // 首页右下淡色校徽水印
    background: context if here().page() == 1 {
      place(bottom + right, dx: 3cm, dy: 1.5cm, image("assets/nju-emblem-watermark.svg", height: 10cm))
    },
  )

  show heading: set text(font: nju-fonts.hei)
  show heading.where(level: 1): it => block(above: 1.5em, below: 0.85em, sticky: true, width: 100%)[
    #set text(size: 15pt, weight: "bold", fill: nju-purple-dark)
    #grid(
      columns: (auto, 1fr),
      column-gutter: 8pt,
      align: horizon,
      [
        #if it.numbering != none {
          text(fill: nju-purple)[#counter(heading).display("1.")]
          h(0.4em)
        }
        #it.body
      ],
      line(length: 100%, stroke: 0.6pt + nju-purple-mid),
    )
  ]
  show heading.where(level: 2): it => block(above: 1.15em, below: 0.65em, sticky: true)[
    #box(width: 3pt, height: 0.85em, fill: nju-purple, radius: 1pt, baseline: -0.1em)#h(6pt)
    #text(size: 12pt, weight: "bold", fill: nju-purple-dark)[
      #if it.numbering != none [#counter(heading).display("1.1")#h(0.5em)]#it.body
    ]
  ]
  show heading.where(level: 3): it => block(above: 1em, below: 0.55em, sticky: true)[
    #text(size: 10.5pt, weight: "bold", fill: nju-purple)[
      #if it.numbering != none [#counter(heading).display("1.1.1")#h(0.5em)]#it.body
    ]
  ]

  nju-title-block(title: title, subtitle: subtitle, course: course, kind: kind, info: info)
  body
}
