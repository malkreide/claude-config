<!-- In die CLAUDE.md jedes *-mcp-Repos übernehmen -->

## Skill-Vorrang
- «findet nichts», «zu wenig Treffer», «Web-UI zeigt mehr», leere Ergebnisse: zuerst `mcp-data-source-probe` und `mcp-data-fidelity` (Recall-/Scope-Frage), NICHT `systematic-debugging`.
- `systematic-debugging` nur bei Fehlern im eigenen Code (Exceptions, Testfehler, Build, Typfehler).
- Probes und Spikes sind Erkundung, keine Bugs – kein Debugging-Protokoll dafür.
- `verification-before-completion` gilt auch für Subagenten-Resultate: Diff und Testlauf zählen, nicht die Erfolgsmeldung des Agenten.
