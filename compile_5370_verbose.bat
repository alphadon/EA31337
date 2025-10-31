@echo off
REM Enhanced compilation script with detailed error reporting
REM For MetaEditor 5.00 build 5370 - Fusion Markets MetaTrader 5

SET METAEDITOR="C:\Program Files\Fusion Markets MetaTrader 5\MetaEditor64.exe"
SET EA_PATH=%~dp0src
SET LOG_FILE=%~dp0compile_errors_5370.txt

echo ============================================
echo EA31337 Compilation for Build 5370
echo Enhanced Error Reporting
echo ============================================
echo.

REM Check if MetaEditor exists
IF NOT EXIST %METAEDITOR% (
    echo ERROR: MetaEditor not found at %METAEDITOR%
    echo Please update the METAEDITOR path in this script
    pause
    exit /b 1
)

echo Compiling EA31337.mq5...
echo Target: %EA_PATH%\EA31337.mq5
echo.

REM Compile and capture output
%METAEDITOR% /compile:"%EA_PATH%\EA31337.mq5" /log:"%LOG_FILE%" /inc:"%EA_PATH%\include" 2>&1

IF %ERRORLEVEL% EQU 0 (
    echo.
    echo ============================================
    echo SUCCESS: Compilation completed successfully!
    echo ============================================
    echo Executable: %EA_PATH%\EA31337.ex5
) ELSE (
    echo.
    echo ============================================
    echo ERROR: Compilation failed
    echo ============================================
    echo.
    echo Extracting errors from log...
    echo.

    REM Try to extract and display errors
    findstr /i /c:"error" %LOG_FILE% > compile_errors_filtered.txt 2>nul

    IF EXIST compile_errors_filtered.txt (
        echo First 30 errors:
        echo ----------------------------------------
        powershell -Command "$lines = Get-Content 'compile_errors_filtered.txt'; $lines[0..29] | ForEach-Object { Write-Host $_ }"
        echo ----------------------------------------
        echo.
        for /f %%A in ('find /c /v "" ^< compile_errors_filtered.txt') do set ERROR_COUNT=%%A
        echo Total errors found: %ERROR_COUNT%
        echo.
        echo Full error list saved to: compile_errors_filtered.txt
    ) ELSE (
        echo Could not extract errors. Check log file manually.
    )

    echo Full log: %LOG_FILE%
)

echo.
echo ============================================
echo Analysis Tips:
echo ============================================
echo 1. Look for patterns like "cannot convert"
echo 2. Check for "type mismatch" errors
echo 3. Focus on fixing errors in base classes first
echo 4. Recompile after each fix to see progress
echo.
pause
