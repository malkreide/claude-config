# claude-config

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![PowerShell](https://img.shields.io/badge/powershell-7+-blue)

> Personal Claude config: global CLAUDE.md, vendored Superpowers skills and helper scripts

🇩🇪 [Deutsche Version](README.de.md)

## Overview

Personal Claude configuration: a global `CLAUDE.md` for Claude Code, three skills extracted from [obra/superpowers](https://github.com/obra/superpowers) for upload to Claude (Desktop/Web), and helper scripts. One repo, so that Windows machines, the GB10 and the Raspberry Pi all share the same configuration.

## Contents

| Path | Purpose |
|---|---|
| `claude-code/CLAUDE.md` | Global rules for Claude Code (`~/.claude/CLAUDE.md`): mandatory skills, taming Superpowers, skill precedence in MCP repos |
| `claude-code/CLAUDE-mcp-repo.md` | Block for the `CLAUDE.md` of individual `*-mcp` repos (only needed when the global rule is not enough) |
| `skills/` | `verification-before-completion`, `systematic-debugging`, `writing-skills` – Superpowers 7.0.2, cross-references localised, TDD reference embedded; source for the skill upload to Claude |
| `scripts/install-skills.ps1` | Copies or links (`-Link`) the skills into `~/.claude/skills` – only for devices without the Superpowers plugin |
| `scripts/add-skill-precedence.ps1` | Appends the MCP repo block to the `CLAUDE.md` of all `*-mcp` repos (dry run without `-Apply`) |

## Setup on a device

**Claude Code (Windows):**
```powershell
git clone https://github.com/malkreide/claude-config "$env:USERPROFILE\src\claude-config"
Copy-Item "$env:USERPROFILE\src\claude-config\claude-code\CLAUDE.md" "$env:USERPROFILE\.claude\CLAUDE.md" -Force
[Environment]::SetEnvironmentVariable("SUPERPOWERS_DISABLE_TELEMETRY","1","User")
```
Superpowers itself comes from the official marketplace: `/plugin install superpowers@claude-plugins-official`.

**Claude Code (Linux, e.g. GB10 or Pi):**
```bash
git clone https://github.com/malkreide/claude-config ~/src/claude-config
mkdir -p ~/.claude && cp ~/src/claude-config/claude-code/CLAUDE.md ~/.claude/CLAUDE.md
echo 'export SUPERPOWERS_DISABLE_TELEMETRY=1' >> ~/.bashrc
```

**Claude Desktop/Web:** Zip each of the three folders under `skills/` separately and upload it as a skill.

## Maintenance

- Change `CLAUDE.md` → commit → on the other devices `git pull` and copy again.
- Superpowers update → read the upstream CHANGELOG, replace the folders under `skills/`, re-apply the adjustments listed in `VENDORED.md`, bump the version.

## Changelog

See [CHANGELOG.md](CHANGELOG.md)

## Contributing

This is a personal configuration repo. Issues and suggestions are welcome; pull requests are reviewed but may not be merged if they do not fit the author's setup.

## Security

The repo contains no secrets or tokens and must not contain any. If you find something sensitive or a problem in the scripts, please report it privately via [GitHub Security Advisories](https://github.com/malkreide/claude-config/security/advisories/new) rather than in a public issue.

## License

MIT License — see [LICENSE](LICENSE). The skills under `skills/` come from obra/superpowers (MIT, Jesse Vincent), see [`skills/LICENSE-superpowers.txt`](skills/LICENSE-superpowers.txt).

## Author

Hayal Özkan · [malkreide](https://github.com/malkreide)
