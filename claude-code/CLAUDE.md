## Pflicht-Skills (Superpowers)
- Vor jeder Erfolgsmeldung (Tests, Build, Fix, Release, «fertig»): `superpowers:verification-before-completion` – Befehl frisch ausführen, Output lesen, erst dann behaupten. Gilt auch für Subagenten-Resultate: Diff und Testlauf zählen, nicht die Erfolgsmeldung des Agenten.
- Bei Bugs, Testfehlern, unerwartetem Verhalten im eigenen Code: `superpowers:systematic-debugging` vor jedem Fix (Root Cause vor Symptom).
- Beim Erstellen oder Ändern eines Skills: `superpowers:writing-skills`, inkl. Baseline-Test ohne Skill vor dem Schreiben.

## Superpowers zähmen
- Brainstorming nur, wenn etwas Wesentliches offen ist. Liegt ein Konzept oder Plan vor (Notion-Export unter `docs/superpowers/specs/` oder eine Referenz in der Repo-CLAUDE.md), gilt der Kurzpfad: Echo in eigenen Worten, eine offene Frage, Design – nicht von vorn beginnen.
- TDD-Ausnahmen ohne Rückfrage: Probes, Spikes, Wegwerf-Prototypen, Raspberry-Pi-Experimente, Notion-Automationen.
- `superpowers:subagent-driven-development` nur bei Plänen mit mehr als 5 Tasks; sonst `superpowers:executing-plans` inline.
- Kleine Änderungen (README, Konfiguration, einzelne Korrektur, Umbenennung) sind «quick clear tasks»: ausführen, sagen was getan wurde, keine Skill-Kaskade.

## Skill-Vorrang in MCP-Repos
Gilt in jedem Repo, dessen Name auf `-mcp` endet:
- «findet nichts», «zu wenig Treffer», «Web-UI zeigt mehr», leere Ergebnisse: zuerst `mcp-data-source-probe` und `mcp-data-fidelity` (Recall-/Scope-Frage), NICHT `superpowers:systematic-debugging`.
- Neue Datenquelle oder neuer Server: `mcp-data-source-probe` ersetzt `superpowers:brainstorming`; die Probe-Reports unter `probes/` sind die Spec.
- `superpowers:systematic-debugging` nur bei Fehlern im eigenen Code (Exceptions, Testfehler, Build, Typfehler).
- Probes und Spikes sind Erkundung, keine Bugs – kein Debugging-Protokoll dafür.
