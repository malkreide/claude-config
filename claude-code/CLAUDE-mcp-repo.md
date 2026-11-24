<!--
Kanonische Quelle für «Teil 1 — Konventionen (portfolio-weit)» der Repo-CLAUDE.md
im MCP-Portfolio.
Quelle und Stand: swiss-cultural-heritage-mcp, CLAUDE.md, Commit 44223412cbdd
(2026-11-14), Abschnitt «## Teil 1» bis vor «## Teil 2».
Eine Abweichung: Der Satz zur ruff-Version verlangt die GEPINNTE Version aus der
Repo-Umgebung (`.venv`) statt «aus der CI» und verbietet `pip install` ohne
Zielumgebung. Begründung: deckt sich mit «Python-Umgebung pro Repo» der globalen
CLAUDE.md; Cloud-Sessions kennen die globale Datei nicht, deshalb hier ohne
Windows-Pfad.
Voraussetzung im Ziel-Repo: docs/claude/wenn-etwas-rot-ist.md und
docs/claude/parallele-agenten.md müssen dort liegen.
-->

## Teil 1 — Konventionen (portfolio-weit)

### Vor der Arbeit

Der SessionStart-Hook meldet beim Sessionstart den Rückstand auf
`origin/<Standard-Branch>` und schweigt bei 0 (Details:
`.claude/hooks/README.md`). In Repos ohne diesen Hook den Standard-Branch
ermitteln, nicht `main` annehmen — Handgriff in
`docs/claude/wenn-etwas-rot-ist.md`. Gates lokal fahren, mit der GEPINNTEN
ruff-Version aus der Umgebung des Repos (`.venv`), nicht mit einem global
installierten ruff; eine andere Version meldet Abweichungen, die niemand
verursacht hat. Nie `pip install` ohne Zielumgebung, auch wenn eine Meldung
es so vorschlägt.

### Tests

Gegenprobe ist Pflicht. Ein Test, der grün bleibt, wenn man die
Implementierung entfernt, prüft nichts. Jede neue Zusicherung einzeln
neutralisieren und zeigen, dass genau die zugehörigen Tests fallen.
Zwei Fallen, die beide grün blieben (Fake-Uhr, `asyncio`-Patch):
`docs/claude/wenn-etwas-rot-ist.md`.

Handgeschriebene Fixtures kodieren die Annahme des Autors und können sie
nicht widerlegen. Mindestens eine aufgezeichnete Antwort pro externem
Endpunkt, mit Aufnahmedatum.

### Bei Bedarf lesen

- Roter Test, rote CI, ein 4xx/403, ein «nicht gefunden», eine scheinbar wirkungslose Option oder ein blockierter PR: lies zuerst `docs/claude/wenn-etwas-rot-ist.md`.
- Vor dem Anlegen eines Branches mit vorgegebenem Namen und bei einem PR mit leerem Diff: lies zuerst `docs/claude/parallele-agenten.md`.

---

# Reserve — nicht Teil der Kurzform

<!-- Bisheriger Inhalt dieser Datei, unverändert. Nicht in die Repo-CLAUDE.md übernehmen. -->

## Skill-Vorrang
- «findet nichts», «zu wenig Treffer», «Web-UI zeigt mehr», leere Ergebnisse: zuerst `mcp-data-source-probe` und `mcp-data-fidelity` (Recall-/Scope-Frage), NICHT `systematic-debugging`.
- `systematic-debugging` nur bei Fehlern im eigenen Code (Exceptions, Testfehler, Build, Typfehler).
- Probes und Spikes sind Erkundung, keine Bugs – kein Debugging-Protokoll dafür.
- `verification-before-completion` gilt auch für Subagenten-Resultate: Diff und Testlauf zählen, nicht die Erfolgsmeldung des Agenten.
