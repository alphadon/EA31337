# Fork Creation and Push Instructions

## Quick Start

### 1. Create Forks on GitHub (Web Interface)

Click these links and click the "Fork" button on each:

1. **Classes:** <https://github.com/EA31337/EA31337-classes/fork>
2. **Indicators:** <https://github.com/EA31337/EA31337-indicators/fork>
3. **Strategies:** <https://github.com/EA31337/EA31337-strategies/fork>
4. **Strategy-Meta:** <https://github.com/EA31337/Strategy-Meta/fork>

Make sure to fork to the `alphadon` account.

### 2. Run Setup Script (Automated)

```bash
cd /workspaces/EA31337
./setup-forks.sh
```

This script will:

- Add fork remotes to all submodules
- Create dev branches where needed
- Prepare submodules for pushing

### 3. Push Changes

Only the **classes** submodule has local changes to push:

```bash
cd src/include/classes
git push fork dev
```

## Manual Setup (Alternative)

If you prefer to do it manually:

### Classes Submodule (HAS CHANGES)

```bash
cd /workspaces/EA31337/src/include/classes
git remote add fork https://github.com/alphadon/EA31337-classes.git
git checkout -b dev  # Already on dev branch
git push fork dev
```

### Indicators Submodule (NO CHANGES)

```bash
cd /workspaces/EA31337/src/indicators
git remote add fork https://github.com/alphadon/EA31337-indicators.git
git checkout -b dev
git push fork dev
```

### Strategies Submodule (NO CHANGES)

```bash
cd /workspaces/EA31337/src/strategies
git remote add fork https://github.com/alphadon/EA31337-strategies.git
git checkout -b dev
git push fork dev
```

### Strategies-Meta Submodule (NO CHANGES)

```bash
cd /workspaces/EA31337/src/strategies-meta
git remote add fork https://github.com/alphadon/Strategy-Meta.git
git checkout -b dev
git push fork dev
```

## Update Main Repo to Use Forks

After forks are created and pushed, update `.gitmodules` in the main repo:

```bash
cd /workspaces/EA31337

# Update .gitmodules to point to your forks
sed -i 's|https://github.com/EA31337/EA31337-classes|https://github.com/alphadon/EA31337-classes|g' .gitmodules
sed -i 's|https://github.com/EA31337/EA31337-indicators|https://github.com/alphadon/EA31337-indicators|g' .gitmodules
sed -i 's|https://github.com/EA31337/EA31337-strategies|https://github.com/alphadon/EA31337-strategies|g' .gitmodules
sed -i 's|https://github.com/EA31337/Strategy-Meta|https://github.com/alphadon/Strategy-Meta|g' .gitmodules

# Sync submodules with new URLs
git submodule sync
git add .gitmodules
git commit -m "Update submodules to point to alphadon forks"
git push origin dev
```

## Verification

Check that all remotes are set up correctly:

```bash
# Classes
cd /workspaces/EA31337/src/include/classes && git remote -v

# Indicators
cd /workspaces/EA31337/src/indicators && git remote -v

# Strategies
cd /workspaces/EA31337/src/strategies && git remote -v

# Strategy-Meta
cd /workspaces/EA31337/src/strategies-meta && git remote -v
```

## What Gets Pushed

### Classes Submodule (13KB patch, 7 commits)

- `4c7f9ddc` - Update type references for MetaEditor 5.00 build 5370
- `f297953e` - Fix SetParams parameter type
- `949a885f` - Fix position variable int to unsigned int
- `d1d8eb8e` - Fix const qualifier for MqlDateTime
- `0aa6984b` - Fix const qualifiers for all MqlDateTime/DateTimeEntry
- `806e9c5f` - Fix struct assignment with explicit field copying
- `3dc416c5` - Fix operator= method hiding

### Other Submodules

Indicators, Strategies, and Strategy-Meta have no local changes. They will just
establish the fork relationship for future updates.

## Troubleshooting

### "Repository not found" error

- Make sure you created the fork on GitHub first
- Verify you're using the correct username (alphadon)
- Check the repository name matches exactly

### "Permission denied" error

- Ensure you're authenticated with GitHub
- Check your SSH keys or HTTPS credentials

### Detached HEAD state

The script automatically creates a dev branch if you're in detached HEAD state.
