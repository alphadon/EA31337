# EA31337 Compilation Script with Edition Detection
# Automatically detects edition from mode.h and names output file accordingly

param(
    [switch]$MQL4,
    [switch]$MQL5 = $true
)

$MetaEditor = "C:\Program Files\Fusion Markets MetaTrader 5\MetaEditor64.exe"
$SrcPath = "$PSScriptRoot\src"
$ModeFile = "$SrcPath\include\common\mode.h"

# Detect edition from mode.h
function Get-Edition {
    $content = Get-Content $ModeFile
    
    # Check each line for uncommented #define
    foreach ($line in $content) {
        if ($line -match '^\s*#define\s+__elite__\s') {
            return "Elite"
        }
        elseif ($line -match '^\s*#define\s+__rider__\s') {
            return "Rider"
        }
        elseif ($line -match '^\s*#define\s+__advanced__\s') {
            return "Advanced"
        }
    }
    
    return "Lite"
}

# Detect if backtest mode
function Get-BacktestSuffix {
    $content = Get-Content $ModeFile -Raw
    if ($content -match '^\s*#define\s+__backtest__' -and $content -notmatch '^\s*//\s*#define\s+__backtest__') {
        return "-Backtest"
    }
    return ""
}

$Edition = Get-Edition
$BacktestSuffix = Get-BacktestSuffix

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "EA31337 Compilation - $Edition Edition" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path $MetaEditor)) {
    Write-Host "ERROR: MetaEditor not found at $MetaEditor" -ForegroundColor Red
    exit 1
}

# Compile MQL5
if ($MQL5) {
    Write-Host "Compiling MQL5 version..." -ForegroundColor Yellow
    
    & $MetaEditor /compile:"$SrcPath\EA31337.mq5" /log /inc:"$SrcPath" /avx2 | Out-Null
    
    if (Test-Path "$SrcPath\EA31337.ex5") {
        $NewName = "EA31337-$Edition$BacktestSuffix.ex5"
        Move-Item "$SrcPath\EA31337.ex5" "$SrcPath\$NewName" -Force
        
        $fileInfo = Get-Item "$SrcPath\$NewName"
        Write-Host "✓ MQL5 compiled successfully" -ForegroundColor Green
        Write-Host "  Output: $NewName" -ForegroundColor Green
        Write-Host "  Size: $([math]::Round($fileInfo.Length / 1MB, 2)) MB" -ForegroundColor Gray
        Write-Host ""
    }
    else {
        Write-Host "✗ MQL5 compilation failed" -ForegroundColor Red
        Write-Host "Check compile_errors_5370.txt for details" -ForegroundColor Yellow
        exit 1
    }
}

# Compile MQL4
if ($MQL4) {
    Write-Host "Compiling MQL4 version..." -ForegroundColor Yellow
    
    & $MetaEditor /compile:"$SrcPath\EA31337.mq4" /log /inc:"$SrcPath" /avx2 | Out-Null
    
    if (Test-Path "$SrcPath\EA31337.ex4") {
        $NewName = "EA31337-$Edition$BacktestSuffix.ex4"
        Move-Item "$SrcPath\EA31337.ex4" "$SrcPath\$NewName" -Force
        
        $fileInfo = Get-Item "$SrcPath\$NewName"
        Write-Host "✓ MQL4 compiled successfully" -ForegroundColor Green
        Write-Host "  Output: $NewName" -ForegroundColor Green
        Write-Host "  Size: $([math]::Round($fileInfo.Length / 1MB, 2)) MB" -ForegroundColor Gray
        Write-Host ""
    }
    else {
        Write-Host "✗ MQL4 compilation failed" -ForegroundColor Red
        exit 1
    }
}

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "Compilation completed!" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
