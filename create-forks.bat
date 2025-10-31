@echo off
REM Windows batch script to create forks using GitHub CLI
REM Run this from Windows Command Prompt, not in Docker

echo ========================================
echo Creating GitHub Forks for EA31337 Submodules
echo ========================================
echo.

REM Check if GitHub CLI is installed
where gh >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: GitHub CLI not found
    echo Please install from: https://cli.github.com/
    pause
    exit /b 1
)

REM Check if logged in
gh auth status >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Not logged in to GitHub CLI
    echo Please run: gh auth login
    pause
    exit /b 1
)

echo Creating forks...
echo.

echo 1. Forking EA31337-classes...
gh repo fork EA31337/EA31337-classes --clone=false --remote=false
echo.

echo 2. Forking EA31337-indicators...
gh repo fork EA31337/EA31337-indicators --clone=false --remote=false
echo.

echo 3. Forking EA31337-strategies...
gh repo fork EA31337/EA31337-strategies --clone=false --remote=false
echo.

echo 4. Forking Strategy-Meta...
gh repo fork EA31337/Strategy-Meta --clone=false --remote=false
echo.

echo ========================================
echo Forks Created Successfully!
echo ========================================
echo.
echo Next steps:
echo 1. Go back to your Dev Container terminal
echo 2. Run: cd /workspaces/EA31337
echo 3. Run: ./setup-forks.sh
echo.
echo Or manually push the classes submodule:
echo   cd /workspaces/EA31337/src/include/classes
echo   git push fork dev
echo.
pause
