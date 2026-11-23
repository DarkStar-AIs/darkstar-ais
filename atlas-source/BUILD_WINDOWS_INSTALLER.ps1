$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot
if (-not (Get-Command py -ErrorAction SilentlyContinue)) { throw 'Python launcher missing. Install Python 3.11 or 3.12.' }
py -3 -m pip install --upgrade pyinstaller
py -3 -m PyInstaller --noconfirm --clean --onedir --name ATLAS --collect-all certifi --hidden-import http.server --add-data 'server.py;.' --add-data 'index.html;.' --add-data 'app.js;.' --add-data 'style.css;.' --add-data 'assets;assets' ATLAS_Launcher.py
$iscc = @("${env:ProgramFiles(x86)}\Inno Setup 6\ISCC.exe", "$env:ProgramFiles\Inno Setup 6\ISCC.exe") | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $iscc) { throw 'Inno Setup 6 is required to build the installer. Install from jrsoftware.org/isinfo.php.' }
& $iscc 'ATLAS.iss'
if ($LASTEXITCODE -ne 0) { throw 'Inno Setup build failed.' }
Write-Host "Installer created: $PSScriptRoot\output\ATLAS-Setup-Windows.exe"
