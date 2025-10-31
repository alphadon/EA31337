# Fork and Push Workflow

## Overview

This workflow creates forks of EA31337 submodules and pushes local changes (particularly
the MetaEditor 5.00 build 5370 fixes in the classes submodule).

## Two-Step Process

### Step 1: Create Forks (Run on Windows)

Since GitHub CLI is installed on Windows, run the fork creation script there.

#### Option A: Using PowerShell (Recommended)

```powershell
cd path\to\EA31337
.\create-forks.ps1
```

#### Option B: Using Command Prompt

```cmd
cd path\to\EA31337
create-forks.bat
```

#### What it does

- Checks for GitHub CLI installation
- Verifies authentication
- Creates forks of:
  - EA31337/EA31337-classes -> alphadon/EA31337-classes
  - EA31337/EA31337-indicators -> alphadon/EA31337-indicators
  - EA31337/EA31337-strategies -> alphadon/EA31337-strategies
  - EA31337/Strategy-Meta -> alphadon/Strategy-Meta

### Step 2: Push Changes (Run in Dev Container)

After forks are created, go to your Dev Container terminal:

```bash
cd /workspaces/EA31337
./push-submodules.sh
```

#### What it does

- Pushes classes submodule (7 commits with build 5370 fixes)
- Pushes other submodules to establish fork relationship
- Creates dev branches where needed

## Manual Process (Alternative)

If you prefer to do it manually:

### 1. Create Forks Manually

Visit these URLs and click "Fork":

1. <https://github.com/EA31337/EA31337-classes/fork>
2. <https://github.com/EA31337/EA31337-indicators/fork>
3. <https://github.com/EA31337/EA31337-strategies/fork>
4. <https://github.com/EA31337/Strategy-Meta/fork>

### 2. Push Classes Submodule (in Dev Container)

```bash
cd /workspaces/EA31337/src/include/classes
git push fork dev
```

This pushes the 7 commits with build 5370 fixes.

## Verification

Check that forks were created and pushed:

```bash
# In Dev Container
cd /workspaces/EA31337

# Check classes
cd src/include/classes && git remote -v && git log --oneline -5

# Check if pushed
git ls-remote fork dev
```

Or visit on GitHub:

- <https://github.com/alphadon/EA31337-classes/tree/dev>
- <https://github.com/alphadon/EA31337-indicators/tree/dev>
- <https://github.com/alphadon/EA31337-strategies/tree/dev>
- <https://github.com/alphadon/Strategy-Meta/tree/dev>

## What Gets Pushed

### Classes Submodule (SUCCESS: HAS CHANGES)

7 commits with build 5370 compatibility fixes:

- Type reference updates (SimpleRef, GetPointer)
- SetParams const parameter
- Dict/DictStruct unsigned int position
- DateTime const qualifiers
- MqlDateTime/DateTimeEntry const parameters
- Struct assignment to field copying
- Operator= method hiding fix

### Other Submodules (INFO: NO CHANGES)

Indicators, Strategies, and Strategy-Meta currently have no local changes.
They're just establishing the fork relationship for future updates.

## Troubleshooting

### "Repository not found" when pushing

**Cause:** Fork doesn't exist yet
**Solution:** Run `create-forks.ps1` or `create-forks.bat` on Windows first

### "Permission denied" when pushing

**Cause:** Git credentials not configured
**Solution:** Check your Git authentication in the Dev Container

### "Already up to date" message

This is normal for submodules without local changes (indicators, strategies, strategies-meta).

## Files Created

- `create-forks.ps1` - PowerShell script for Windows
- `create-forks.bat` - Batch script for Windows
- `push-submodules.sh` - Bash script for Dev Container
- `setup-forks.sh` - Interactive setup script
- `FORK_SETUP_GUIDE.md` - Detailed manual instructions

## Quick Reference

```bash
# Windows (PowerShell)
.\create-forks.ps1

# Dev Container
./push-submodules.sh

# Verify
git remote -v  # in each submodule
```
