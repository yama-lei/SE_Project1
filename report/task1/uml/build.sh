#!/usr/bin/env bash
# 由 *.puml 重新生成报告引用的 SVG。需要 Java 与 PlantUML（无需 Graphviz，使用 smetana 布局）。
# PLANTUML_JAR 默认为 ~/.local/share/plantuml/plantuml.jar
set -euo pipefail
cd "$(dirname "$0")"
jar="${PLANTUML_JAR:-$HOME/.local/share/plantuml/plantuml.jar}"
java -Djava.awt.headless=true -jar "$jar" -tsvg usecase.puml class.puml state.puml settle.puml
