# Worker-Reviewer-Loop

Usage-optimierter Arbeitsmodus für Claude Code: Ein günstiger **Worker** implementiert, ein **Reviewer** prüft nur den Diff, der **Orchestrator** (`/wrl`) steuert mit minimalem Kontext.

## Benutzung
```
/wrl Füge eine Healthcheck-Route hinzu
/wrl --light Tippfehler in README korrigieren und Links prüfen
/wrl --deep --commit Auth-Middleware auf JWT umstellen
```
| Flag | Wirkung |
|---|---|
| (keins) | Worker Sonnet, Reviewer Sonnet |
| `--light` | Worker Haiku (einfache, mechanische Aufgaben) |
| `--deep` | Reviewer Opus (sicherheits-/architekturkritisch) |
| `--commit` | nach `APPROVED` committen (nie automatisch pushen) |

## Ablauf
1. Orchestrator schreibt `.wrl/task.md` (Ziel, Akzeptanzkriterien, Prüfbefehle, Nicht-Ziele).
2. Worker setzt um → `.wrl/work.md`.
3. Reviewer prüft Diff + Prüfbefehle → `.wrl/review.md` (`APPROVED` / `CHANGES_REQUESTED`).
4. Bei Änderungswünschen nächste Runde, **max. 3**; danach Abbruch mit offenen Findings.

## Warum das Usage spart
- Teures Modell nur dort, wo es nötig ist (Review, optional `--deep`).
- Kommunikation per Datei statt langer Prompts; Orchestrator liest nur die VERDICT-Zeile.
- Reviewer sieht nur den Diff, meldet nur belegbare Blocker.
- Harte Rundengrenze, keine Parallel-Agents, Triviales ohne Loop.

## Installation
- **In diesem Repo:** funktioniert direkt (Dateien in `.claude/`).
- **Global für alle Projekte:** `./install.sh` (kopiert nach `~/.claude`).
- **In ein anderes Projekt:** `./install.sh /pfad/zum/projekt`.

## Anpassen
- Modelle: `model:` im Frontmatter von `.claude/agents/worker.md` / `reviewer.md`.
- Rundenlimit und Regeln: `.claude/skills/wrl/SKILL.md`.
- Projektspezifische Prüfbefehle gehören in die jeweilige `task.md` (Vorlage: `templates/task.md`).
