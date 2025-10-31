@echo off
REM Script to pull latest changes and compile
REM Run this from your Windows command prompt after pulling in VS Code

SET METAEDITOR="C:\Program Files\Fusion Markets MetaTrader 5\MetaEditor64.exe"
SET EA_PATH=%~dp0src

echo ============================================
echo EA31337 Sync and Compile
echo ============================================
echo.
echo NOTE: Make sure you've pulled the latest changes in VS Code first!
echo       (git pull origin dev in the Dev Container)
echo.
pause

echo Checking MetaEditor...
IF NOT EXIST %METAEDITOR% (
    echo ERROR: MetaEditor not found
    pause
    exit /b 1
)

echo.
echo Compiling EA31337.mq5...
%METAEDITOR% /compile:"%EA_PATH%\EA31337.mq5" /log:"%~dp0compile_output.log" /inc:"%EA_PATH%\include"

IF %ERRORLEVEL% EQU 0 (
    echo.
    echo SUCCESS: Compilation completed!
) ELSE (
    echo.
    echo ERROR: Compilation failed
    echo.
    echo Showing first 30 errors:
    findstr /i "error" "%~dp0compile_output.log" > "%~dp0errors_only.txt" 2>nul
    powershell -Command "if (Test-Path 'errors_only.txt') { Get-Content 'errors_only.txt' | Select-Object -First 30 }"
)

echo.
pause
