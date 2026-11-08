# Hängt den Block «Skill-Vorrang» aus CLAUDE-mcp-repo.md an die CLAUDE.md aller passenden GitHub-Repos an.
# Idempotent: Repos, deren CLAUDE.md den Marker schon enthält, werden übersprungen.
#
#   .\add-skill-precedence.ps1            Dry-Run: zeigt nur, was passieren würde
#   .\add-skill-precedence.ps1 -Apply     führt aus: klont flach, ergänzt, committet, pusht
#
# Voraussetzungen: gh CLI angemeldet, git im PATH.
param(
  [string]$Owner     = "malkreide",
  [string]$Pattern   = "-mcp$",
  [string]$BlockFile = (Join-Path (Split-Path $PSScriptRoot -Parent) "claude-code\CLAUDE-mcp-repo.md"),
  [string]$Marker    = "## Skill-Vorrang",
  [string]$AuthorEmail = "8864492+malkreide@users.noreply.github.com",
  [switch]$Apply
)
$ErrorActionPreference = "Continue"
$utf8NoBom = New-Object System.Text.UTF8Encoding $false

if (-not (Test-Path $BlockFile)) { throw "Blockdatei nicht gefunden: $BlockFile" }
$block = (Get-Content $BlockFile -Encoding UTF8 | Select-Object -Skip 2) -join "`n"

$work = Join-Path $env:TEMP "skill-precedence"
New-Item -ItemType Directory -Force -Path $work | Out-Null

$repos = gh repo list $Owner --limit 300 --json name,isArchived,defaultBranchRef | ConvertFrom-Json |
         Where-Object { $_.name -match $Pattern -and -not $_.isArchived }

Write-Host ("Modus: " + $(if ($Apply) { "APPLY" } else { "Dry-Run" }) + "  |  Repos passend zu '$Pattern': $($repos.Count)")
Write-Host ""

$done = 0; $skipped = 0; $failed = 0
foreach ($r in $repos) {
  $name   = $r.name
  $branch = $r.defaultBranchRef.name
  $dir    = Join-Path $work $name
  if (Test-Path $dir) { Remove-Item $dir -Recurse -Force }

  gh repo clone "$Owner/$name" $dir -- --depth 1 --quiet
  if ($LASTEXITCODE -ne 0) { Write-Host "  ! $name : Clone fehlgeschlagen"; $failed++; continue }

  $file = Join-Path $dir "CLAUDE.md"
  $exists = Test-Path $file
  if ($exists -and ((Get-Content $file -Raw -Encoding UTF8) -match [regex]::Escape($Marker))) {
    Write-Host "  = $name : Marker bereits vorhanden"; $skipped++; continue
  }

  if (-not $Apply) {
    Write-Host ("  + $name : wuerde ergaenzt (" + $(if ($exists) { "CLAUDE.md vorhanden" } else { "CLAUDE.md neu" }) + ")")
    $done++; continue
  }

  $prefix = if ($exists) { "`n" } else { "" }
  [System.IO.File]::AppendAllText($file, $prefix + $block + "`n", $utf8NoBom)

  Push-Location $dir
  git config user.email $AuthorEmail
  git add CLAUDE.md
  git commit -q -m "Add skill precedence rules to CLAUDE.md"
  git push -q origin $branch
  $ok = ($LASTEXITCODE -eq 0)
  Pop-Location

  if ($ok) { Write-Host "  + $name : ergaenzt und gepusht"; $done++ }
  else     { Write-Host "  ! $name : Push fehlgeschlagen"; $failed++ }
}

Write-Host ""
Write-Host "Ergaenzt: $done   Uebersprungen: $skipped   Fehler: $failed"
Write-Host "Arbeitskopien unter: $work (kann geloescht werden)"
