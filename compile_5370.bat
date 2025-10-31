@echo off
REM Compilation script for MetaEditor 5.00 build 5370
REM Fusion Markets MetaTrader 5

SET METAEDITOR="C:\Program Files\Fusion Markets MetaTrader 5\MetaEditor64.exe"
SET EA_PATH=%~dp0src

echo ============================================
echo EA31337 Compilation for Build 5370
echo ============================================
echo.

REM Check if MetaEditor exists
IF NOT EXIST %METAEDITOR% (
    echo ERROR: MetaEditor not found at %METAEDITOR%
    echo Please update the METAEDITOR path in this script
    pause
    exit /b 1
)

REM Compile MQL5 version
echo Compiling MQL5 version...
%METAEDITOR% /compile:"%EA_PATH%\EA31337.mq5" /log /inc:"%EA_PATH%"
IF %ERRORLEVEL% NEQ 0 (
    echo ERROR: MQL5 compilation failed
    pause
    exit /b 1
)
echo MQL5 compilation completed successfully
echo.

REM Compile MQL4 version
echo Compiling MQL4 version...
%METAEDITOR% /compile:"%EA_PATH%\EA31337.mq4" /log /inc:"%EA_PATH%"
IF %ERRORLEVEL% NEQ 0 (
    echo ERROR: MQL4 compilation failed
    pause
    exit /b 1
)
echo MQL4 compilation completed successfully
echo.

echo ============================================
echo Compilation completed!
echo Check for .ex4 and .ex5 files in src folder
echo ============================================
pause
