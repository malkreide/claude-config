## Pflicht-Skills (Superpowers)
- Vor jeder Erfolgsmeldung (Tests, Build, Fix, Release, «fertig»): `superpowers:verification-before-completion` – Befehl frisch ausführen, Output lesen, erst dann behaupten. Gilt auch für Subagenten-Resultate: Diff und Testlauf zählen, nicht die Erfolgsmeldung des Agenten.
- Bei Bugs, Testfehlern, unerwartetem Verhalten im eigenen Code: `superpowers:systematic-debugging` vor jedem Fix (Root Cause vor Symptom).
- Skills bauen: `skill-creator` für Aufbau, Frontmatter und Scaffold; `superpowers:writing-skills` für den Nachweis, dass der Skill Verhalten ändert (Baseline ohne Skill → Skill → Re-Test). Neuer Skill: skill-creator, dann writing-skills. Bestehender Skill: nur writing-skills. Nie beide als Alternativen behandeln.

## Superpowers zähmen
- Brainstorming nur, wenn etwas Wesentliches offen ist. Liegt ein Konzept oder Plan vor (Notion-Export unter `docs/superpowers/specs/` oder eine Referenz in der Repo-CLAUDE.md), gilt der Kurzpfad: Echo in eigenen Worten, eine offene Frage, Design – nicht von vorn beginnen.
- TDD-Ausnahmen ohne Rückfrage: Probes, Spikes, Wegwerf-Prototypen, Raspberry-Pi-Experimente, Notion-Automationen.
- `superpowers:subagent-driven-development` nur bei Plänen mit mehr als 5 Tasks; sonst `superpowers:executing-plans` inline.
- Kleine Änderungen (README, Konfiguration, einzelne Korrektur, Umbenennung) sind «quick clear tasks»: ausführen, sagen was getan wurde, keine Skill-Kaskade.

## Abschlusskette (Release)
Reihenfolge, wenn etwas als fertig gelten oder publiziert werden soll – jeder Schritt ist ein Gate für den nächsten:
1. `superpowers:verification-before-completion` – Tests, Lint, Build frisch gelaufen und gelesen.
2. In `*-mcp`-Repos: `mcp-audit` – keine offenen Blocker-Findings.
3. `github-repo` – `validate_repo.py` ohne ERROR, Secrets-Check, README beider Sprachen, Release-Gate (Schritt 12).
4. `superpowers:finishing-a-development-branch` – Merge- oder PR-Entscheid, Worktree aufräumen.
Ein Gate überspringen heisst: nicht fertig. Das letzte Gate (github-repo) prüft, ob die vorherigen gelaufen sind.

## Skill-Vorrang in MCP-Repos
Gilt in jedem Repo, dessen Name auf `-mcp` endet:
- «findet nichts», «zu wenig Treffer», «Web-UI zeigt mehr», leere Ergebnisse: zuerst `mcp-data-source-probe` und `mcp-data-fidelity` (Recall-/Scope-Frage), NICHT `superpowers:systematic-debugging`.
- Neue Datenquelle oder neuer Server: `mcp-data-source-probe` ersetzt `superpowers:brainstorming`; die Probe-Reports unter `probes/` sind die Spec.
- `superpowers:systematic-debugging` nur bei Fehlern im eigenen Code (Exceptions, Testfehler, Build, Typfehler).
- Probes und Spikes sind Erkundung, keine Bugs – kein Debugging-Protokoll dafür.

## Skill-Vorrang in Raspberry-Pi-Repos
Gilt in Repos, deren Name auf `-pi` endet oder die Pi-Hardware ansprechen (GPIO, Hailo, Picamera2, dtoverlay):
- `raspberry-pi-ai` ist der Bau-Skill (Bauplan, Komponenten, Setup, Edge-AI-Deployment) – an der Stelle, an der in MCP-Repos `mcp-builder` steht.
- Hardware-Fehler (Sensor liefert nichts, I2C nicht gefunden, Kamera nicht erkannt): zuerst die Debug-Schritte aus `raspberry-pi-ai`, `superpowers:systematic-debugging` nur bei Fehlern im eigenen Python-Code.
- Verifikation heisst: auf dem Gerät gelaufen, nicht nur lokal. Ohne Gerätezugriff gilt «ungetestet», nicht «fertig».
