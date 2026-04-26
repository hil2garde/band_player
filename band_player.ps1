param(
    [string]$Track = "",
    [switch]$gp,
    [switch]$daw
)

# ----------------------------------------------------------
# Chargement du .env (meme dossier que le script)
# ----------------------------------------------------------
$envFile = Join-Path $PSScriptRoot ".env"

if (-not (Test-Path $envFile)) {
    Write-Error ".env introuvable dans $PSScriptRoot. Copie .env.example en .env et remplis-le."
    exit 1
}

Get-Content $envFile | ForEach-Object {
    if ($_ -match "^\s*#" -or $_ -match "^\s*$") { return }
    $parts = $_ -split "=", 2
    Set-Variable -Name $parts[0].Trim() -Value $parts[1].Trim() -Scope Script
}

# ----------------------------------------------------------
# Helpers
# ----------------------------------------------------------
function Open-File($path, $label) {
    if ($path -and (Test-Path $path)) {
        Write-Host "✅ $label" -ForegroundColor Green
        Start-Process $path
    }
    else {
        Write-Host "❌ Echec : $label" -ForegroundColor Red
        Write-Host "   $path" -ForegroundColor DarkGray
    }
}

function Open-Folder($path) {
    if (Test-Path $path) {
        Start-Process explorer.exe $path
    }
    else {
        Write-Warning "Dossier introuvable : $path"
    }
}

# ----------------------------------------------------------
# Resolution du mode (gp / daw / les deux par defaut)
# ----------------------------------------------------------
$openGp = $gp -or (-not $gp -and -not $daw)
$openDaw = $daw -or (-not $gp -and -not $daw)

# ----------------------------------------------------------
# Commandes speciales
# ----------------------------------------------------------
switch ($Track.ToLower()) {

    { $_ -in "help", "--help", "-h" } {
        Write-Host ""
        Write-Host "  $BAND_NAME — commandes disponibles" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "  band                  Ouvre le dossier du groupe"
        Write-Host "  band <track>          Ouvre <track>.gp + <track>.rpp"
        Write-Host "  band <track> -gp      Seulement le fichier Guitar Pro"
        Write-Host "  band <track> -daw     Seulement le projet Reaper"
        Write-Host "  band all              Tous les .gp"
        Write-Host "  band all -gp          Tous les .gp (explicite)"
        Write-Host "  band all -daw         Tous les .rpp"
        Write-Host "  band notes            Ouvre notes.md"
        Write-Host "  band metro            Ouvre le métronome en ligne"
        Write-Host "  band help             Affiche cette aide"
        Write-Host ""
        exit
    }

    "notes" {
        Open-File $NOTES_FILE "Notes - $BAND_NAME"
        exit
    }

    "metro" {
        Write-Host "Metronome -> $METRO_URL" -ForegroundColor Yellow
        Start-Process $METRO_URL
        exit
    }

    "all" {
        Write-Host "Ouverture ALL - $BAND_NAME" -ForegroundColor Yellow        
        if ($openGp) {
            Write-Host "[GP]" -ForegroundColor Cyan
            Get-ChildItem -Path $GP_FOLDER -Filter "*.gp" -ErrorAction SilentlyContinue |
            ForEach-Object { Open-File $_.FullName "$($_.BaseName.ToUpper()) - $BAND_NAME" }
        }
        if ($openDaw) {
            Write-Host "[DAW]" -ForegroundColor Cyan
            Get-ChildItem -Path $DAW_FOLDER -Filter "*.rpp" -ErrorAction SilentlyContinue |
            ForEach-Object { Open-File $_.FullName "$($_.BaseName.ToUpper()) - $BAND_NAME" }
        }
        exit
    }

    "" {
        Write-Host "Dossier $BAND_NAME" -ForegroundColor Yellow
        Open-Folder $BASE_ROOT
        exit
    }
}

# ----------------------------------------------------------
# band <code_morceau>  ex : band sp  /  band pmd -gp
# ----------------------------------------------------------
$trackLabel = "$($Track.ToUpper()) - $BAND_NAME"

if ($openGp) {
    Write-Host "[GP]" -ForegroundColor Cyan
    Open-File (Join-Path $GP_FOLDER "$Track.gp") $trackLabel
}

if ($openDaw) {
    Write-Host "[DAW]" -ForegroundColor Cyan
    Open-File (Join-Path $DAW_FOLDER "$Track.rpp") $trackLabel
}