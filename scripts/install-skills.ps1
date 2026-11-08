# Installiert die drei gevendorten Skills nach ~/.claude/skills (Claude Code, persönliche Skills).
#
#   .\install.ps1          kopiert die Ordner (für Geräte ohne Git-Checkout)
#   .\install.ps1 -Link    legt Junctions auf diesen Checkout an; danach wirkt `git pull` direkt
#
# Aus dem Ordner ausführen, in dem das Skript liegt (bei -Link: aus dem Git-Checkout).
param([switch]$Link)
$ErrorActionPreference = "Stop"

$src    = Join-Path (Split-Path $PSScriptRoot -Parent) "skills"
$dst    = Join-Path $env:USERPROFILE ".claude\skills"
$skills = "verification-before-completion","systematic-debugging","writing-skills"

New-Item -ItemType Directory -Force -Path $dst | Out-Null

foreach ($s in $skills) {
  $target = Join-Path $dst $s
  $source = Join-Path $src $s

  if (Test-Path $target) {
    $item = Get-Item $target -Force
    if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
      # Junction: nur die Verknüpfung entfernen, nie den Zielordner
      cmd /c rmdir "$target" | Out-Null
    } else {
      Remove-Item $target -Recurse -Force
    }
  }

  if ($Link) {
    New-Item -ItemType Junction -Path $target -Target $source | Out-Null
    Write-Host "verknuepft: $target -> $source"
  } else {
    Copy-Item $source $target -Recurse
    Write-Host "kopiert:    $target"
  }
}

Write-Host ""
Write-Host "Kontrolle:  Get-ChildItem `"$dst`" -Directory"
if (-not $Link) {
  Write-Host "Naechster Schritt: Block aus CLAUDE-global.md in $env:USERPROFILE\.claude\CLAUDE.md uebernehmen."
}
