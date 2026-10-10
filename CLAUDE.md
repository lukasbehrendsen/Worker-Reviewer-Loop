# Worker-Reviewer-Loop

Dieses Repo enthält ein wiederverwendbares Setup für Claude Code: `/wrl <Aufgabe>` startet einen Loop aus günstigem Worker und prüfendem Reviewer (max. 3 Runden).

- Antworten auf Deutsch, knapp.
- Handoff zwischen Agents ausschließlich über `.wrl/task.md`, `.wrl/work.md`, `.wrl/review.md` (gitignored).
- Orchestrator codet nicht selbst; Worker committet nicht; nie pushen/PR ohne ausdrückliche Anweisung.
- Keine Secrets in Dateien oder Ausgaben.
