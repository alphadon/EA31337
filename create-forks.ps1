# PowerShell script to create forks using GitHub CLI
# Run this from Windows PowerShell, not in Docker

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Creating GitHub Forks for EA31337 Submodules" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Check if GitHub CLI is installed
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    Write-Host "ERROR: GitHub CLI not found" -ForegroundColor Red
    Write-Host "Please install from: https://cli.github.com/" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

# Check if logged in
$authStatus = gh auth status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Not logged in to GitHub CLI" -ForegroundColor Red
    Write-Host "Please run: gh auth login" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "Creating forks..." -ForegroundColor Green
Write-Host ""

$repos = @(
    "EA31337/EA31337-classes",
    "EA31337/EA31337-indicators",
    "EA31337/EA31337-strategies",
    "EA31337/Strategy-Meta"
)

$success = $true

foreach ($repo in $repos) {
    $repoName = $repo.Split("/")[1]
    Write-Host "Forking $repo..." -ForegroundColor Yellow

    $result = gh repo fork $repo --clone=false --remote=false 2>&1

    if ($LASTEXITCODE -eq 0) {
        Write-Host "  SUCCESS: $repoName forked successfully" -ForegroundColor Green
    } else {
        if ($result -match "already exists") {
            Write-Host "  INFO: $repoName fork already exists" -ForegroundColor Cyan
        } else {
            Write-Host "  ERROR: Failed to fork $repoName" -ForegroundColor Red
            Write-Host "    $result" -ForegroundColor Red
            $success = $false
        }
    }
    Write-Host ""
}

Write-Host "==========================================" -ForegroundColor Cyan

if ($success) {
    Write-Host "Forks Created Successfully!" -ForegroundColor Green
} else {
    Write-Host "Some forks failed - please check errors above" -ForegroundColor Yellow
}

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Go back to your Dev Container terminal"
Write-Host "2. Run: cd /workspaces/EA31337"
Write-Host "3. Run: ./push-submodules.sh"
Write-Host ""
Write-Host "Or manually push the classes submodule:"
Write-Host "  cd /workspaces/EA31337/src/include/classes"
Write-Host "  git push fork dev"
Write-Host ""

Read-Host "Press Enter to exit"
