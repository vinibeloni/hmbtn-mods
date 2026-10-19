#requires -version 5.1
<#
Copy mods into the game's mods\hmbtn\ folder.

  .\install.ps1 -GameDir "C:\path\to\folder\with\the\exe"
  .\install.ps1 -GameDir "C:\path\to\folder\with\the\exe" -Mod save-anywhere

Restart the game afterwards: mods are read at launch.
#>
param(
    [Parameter(Mandatory = $true)][string]$GameDir,
    [string[]]$Mod
)
$ErrorActionPreference = 'Stop'

if (-not (Test-Path -LiteralPath $GameDir -PathType Container)) {
    throw "GameDir does not exist: $GameDir"
}
$exe = Get-ChildItem -LiteralPath $GameDir -Filter 'Harvest_Moon*.exe' -ErrorAction SilentlyContinue | Select-Object -First 1
if (-not $exe) {
    throw "No Harvest_Moon*.exe in $GameDir. Pass the folder that holds the game executable."
}

$src = Join-Path $PSScriptRoot 'mods'
$names = if ($Mod) { $Mod } else { Get-ChildItem -LiteralPath $src -Directory | ForEach-Object Name }
$dest = Join-Path $GameDir 'mods\hmbtn'
New-Item -ItemType Directory -Force -Path $dest | Out-Null

foreach ($n in $names) {
    $from = Join-Path $src $n
    if (-not (Test-Path -LiteralPath (Join-Path $from 'mod.toml'))) { throw "Unknown mod: $n" }
    $to = Join-Path $dest $n
    if (Test-Path -LiteralPath $to) { Remove-Item -Recurse -Force -LiteralPath $to }
    Copy-Item -Recurse -LiteralPath $from -Destination $to
    Write-Host "installed $n -> $to"
}
Write-Host "Restart the game to load them."