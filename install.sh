#!/usr/bin/env bash
# Installiert den Worker-Reviewer-Loop global (~/.claude) oder in ein Zielprojekt.
# Nutzung:  ./install.sh            -> global (für alle Projekte)
#           ./install.sh /pfad/proj -> nur in dieses Projekt
set -euo pipefail
SRC="$(cd "$(dirname "$0")" && pwd)"
if [ $# -ge 1 ]; then DEST="$1/.claude"; PROJ="$1"; else DEST="$HOME/.claude"; PROJ=""; fi
mkdir -p "$DEST/agents" "$DEST/skills/wrl"
cp "$SRC"/.claude/agents/{worker,reviewer}.md "$DEST/agents/"
cp "$SRC"/.claude/skills/wrl/SKILL.md "$DEST/skills/wrl/"
if [ -n "$PROJ" ]; then
  mkdir -p "$PROJ/templates"; cp "$SRC/templates/task.md" "$PROJ/templates/task.md"
  grep -qxF '.wrl/' "$PROJ/.gitignore" 2>/dev/null || echo '.wrl/' >> "$PROJ/.gitignore"
else
  mkdir -p "$DEST/skills/wrl"; cp "$SRC/templates/task.md" "$DEST/skills/wrl/task-template.md"
  sed -i 's#Vorlage `templates/task.md`#Vorlage `templates/task.md` (global: `~/.claude/skills/wrl/task-template.md`)#' "$DEST/skills/wrl/SKILL.md"
fi
echo "Installiert nach $DEST – in Claude Code mit /wrl <Aufgabe> starten."
