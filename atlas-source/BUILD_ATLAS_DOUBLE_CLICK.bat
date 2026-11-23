@echo off
setlocal
cd /d "%~dp0"
title ATLAS - Windows Installer Builder
 echo ====================================================
 echo   ATLAS - Build your Windows installer
 echo ====================================================
 echo.
 echo This will package ATLAS and create its setup EXE.
 echo Keep this window open until it finishes.
 echo.
where py >nul 2>nul
if not errorlevel 1 (
  set "PY=py -3"
  goto foundpython
)
where python >nul 2>nul
if not errorlevel 1 (
  set "PY=python"
  goto foundpython
)
echo ERROR: Python not found. Install Python from python.org
 goto failed
:foundpython
%PY% --version
if errorlevel 1 goto failed
%PY% -m pip --version >nul 2>nul
if errorlevel 1 (
 echo ERROR: Python pip is missing.
 goto failed
)
echo.
echo [1/3] Installing build tools...
%PY% -m pip install --user --upgrade pyinstaller
if errorlevel 1 goto failed
echo.
echo [2/3] Packaging ATLAS...
%PY% -m PyInstaller --noconfirm --clean --onedir --name ATLAS --collect-all certifi --hidden-import=http.server --add-data "server.py;." --add-data "index.html;." --add-data "app.js;." --add-data "style.css;." --add-data "assets;assets" ATLAS_Launcher.py
if errorlevel 1 goto failed
set "ISCC=%ProgramFiles(x86)%\Inno Setup 6\ISCC.exe"
if exist "%ISCC%" goto inno
set "ISCC=%ProgramFiles%\Inno Setup 6\ISCC.exe"
if exist "%ISCC%" goto inno
echo ERROR: Inno Setup 6 not found. Install it from jrsoftware.org/isinfo.php
 goto failed
:inno
echo.
echo [3/3] Building Windows installer...
"%ISCC%" "ATLAS.iss"
if errorlevel 1 goto failed
echo.
echo SUCCESS: ATLAS installer created!
echo File: %~dp0output\ATLAS-Setup-Windows.exe
start "" "%~dp0output"
echo.
pause
exit /b 0
:failed
echo.
echo BUILD FAILED. Please send a screenshot of this window.
echo This window will stay open until you press a key.
pause
exit /b 1
