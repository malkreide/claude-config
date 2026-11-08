# claude-config

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![PowerShell](https://img.shields.io/badge/powershell-7+-blue)

> Persönliche Claude-Konfiguration: globale CLAUDE.md, herausgelöste Superpowers-Skills und Hilfsskripte

🇬🇧 [English Version](README.md)

## Übersicht

Persönliche Claude-Konfiguration: globale `CLAUDE.md` für Claude Code, drei aus [obra/superpowers](https://github.com/obra/superpowers) herausgelöste Skills für den Upload in Claude (Desktop/Web) sowie Hilfsskripte. Ein Repo, damit Windows-Rechner, GB10 und Raspberry Pi dieselbe Konfiguration haben.

## Inhalt

| Pfad | Zweck |
|---|---|
| `claude-code/CLAUDE.md` | Globale Regeln für Claude Code (`~/.claude/CLAUDE.md`): Pflicht-Skills, Superpowers zähmen, Skill-Vorrang in MCP-Repos |
| `claude-code/CLAUDE-mcp-repo.md` | Block für die `CLAUDE.md` einzelner `*-mcp`-Repos (nur nötig, wenn die globale Regel nicht reicht) |
| `skills/` | `verification-before-completion`, `systematic-debugging`, `writing-skills` – Superpowers 7.0.2, Querverweise lokalisiert, TDD-Referenz eingebettet; Quelle für den Skill-Upload in Claude |
| `scripts/install-skills.ps1` | Kopiert oder verknüpft (`-Link`) die Skills nach `~/.claude/skills` – nur für Geräte ohne Superpowers-Plugin |
| `scripts/add-skill-precedence.ps1` | Hängt den MCP-Repo-Block an die `CLAUDE.md` aller `*-mcp`-Repos an (Dry-Run ohne `-Apply`) |

## Setup auf einem Gerät

**Claude Code (Windows):**
```powershell
git clone https://github.com/malkreide/claude-config "$env:USERPROFILE\src\claude-config"
Copy-Item "$env:USERPROFILE\src\claude-config\claude-code\CLAUDE.md" "$env:USERPROFILE\.claude\CLAUDE.md" -Force
[Environment]::SetEnvironmentVariable("SUPERPOWERS_DISABLE_TELEMETRY","1","User")
```
Superpowers selbst kommt aus dem offiziellen Marketplace: `/plugin install superpowers@claude-plugins-official`.

**Claude Code (Linux, z. B. GB10 oder Pi):**
```bash
git clone https://github.com/malkreide/claude-config ~/src/claude-config
mkdir -p ~/.claude && cp ~/src/claude-config/claude-code/CLAUDE.md ~/.claude/CLAUDE.md
echo 'export SUPERPOWERS_DISABLE_TELEMETRY=1' >> ~/.bashrc
```

**Claude Desktop/Web:** Die drei Ordner unter `skills/` je einzeln zippen und als Skill hochladen.

## Pflege

- `CLAUDE.md` ändern → committen → auf den anderen Geräten `git pull` und erneut kopieren.
- Superpowers-Update → Upstream-CHANGELOG lesen, Ordner unter `skills/` ersetzen, Anpassungen gemäss `VENDORED.md` erneut anwenden, Version nachführen.

## Changelog

Siehe [CHANGELOG.md](CHANGELOG.md)

## Mitwirken

Dies ist ein persönliches Konfigurations-Repo. Issues und Vorschläge sind willkommen; Pull Requests werden angeschaut, aber nicht zwingend übernommen, wenn sie nicht zum eigenen Setup passen.

## Sicherheit

Das Repo enthält keine Secrets oder Tokens und darf auch keine enthalten. Wer etwas Sensibles oder ein Problem in den Skripten findet, meldet es bitte vertraulich über [GitHub Security Advisories](https://github.com/malkreide/claude-config/security/advisories/new) statt in einem öffentlichen Issue.

## Lizenz

MIT-Lizenz – siehe [LICENSE](LICENSE). Die Skills unter `skills/` stammen aus obra/superpowers (MIT, Jesse Vincent), siehe [`skills/LICENSE-superpowers.txt`](skills/LICENSE-superpowers.txt).

## Autor

Hayal Özkan · [malkreide](https://github.com/malkreide)
