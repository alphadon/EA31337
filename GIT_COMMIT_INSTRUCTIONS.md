# Git Commit Instructions for MetaEditor 5370 Fixes

## Prerequisites

Before running these commands, ensure you have:
1. Forked all necessary repositories to your `alphadon` GitHub account
2. Added fork remotes to each submodule (see FORK_SETUP_GUIDE.md)
3. Write permissions to push to your forks

## Commit Order

Commits must be made from the innermost submodules outward, then to parent repositories.

---

## 1. Strategy-Pinbar Repository

```bash
cd src/strategies/Pinbar

# Ensure on dev branch
git checkout dev || git checkout -b dev

# Stage changes
git add Stg_Pinbar.mqh

# Commit
git commit -m "Fix MetaEditor 5370 compatibility: Add explicit enum cast to CheckPattern

- Cast PATTERN_1CANDLE_IS_SPINNINGTOP to int for proper method resolution
- Resolves method hiding warning with build 5370 stricter overload rules
- Fixes 2 compilation warnings"

# Push to your fork
git push fork dev
# Or if fork remote not set: git push https://github.com/alphadon/Strategy-Pinbar.git dev

cd ../../..
```

---

## 2. Strategy-Retracement Repository

```bash
cd src/strategies/Retracement

# Ensure on dev branch
git checkout dev || git checkout -b dev

# Stage changes
git add Stg_Retracement.mqh

# Commit
git commit -m "Fix MetaEditor 5370 compatibility: Add BarOHLC constructor

- Add explicit constructor for Retracement_BarOHLC accepting BarOHLC base class
- Resolves deprecated initialization pattern warnings (2 instances)
- Prevents fallback to assignment operator during initialization
- Build 5370 requires constructors for initialization, not assignment operators"

# Push to your fork
git push fork dev
# Or if fork remote not set: git push https://github.com/alphadon/Strategy-Retracement.git dev

cd ../../..
```

---

## 3. Strategy-Meta_Pattern Repository

```bash
cd src/strategies-meta/Meta_Pattern

# Ensure on dev branch
git checkout dev || git checkout -b dev

# Stage changes
git add Stg_Meta_Pattern.mqh

# Commit
git commit -m "Fix MetaEditor 5370 compatibility: Add explicit enum casts

- Cast pattern enums to int in CheckPattern calls
- Resolves method hiding issues with build 5370 stricter overload rules
- Fixes 2 compilation warnings for proper method resolution"

# Push to your fork
git push fork dev
# Or if fork remote not set: git push https://github.com/alphadon/Strategy-Meta_Pattern.git dev

cd ../../..
```

---

## 4. EA31337-strategies Repository

After committing the nested strategy submodules, update the parent:

```bash
cd src/strategies

# Ensure on dev branch
git checkout dev || git checkout -b dev

# Update submodule references
git add Pinbar Retracement

# Commit
git commit -m "Update submodules: MetaEditor 5370 compatibility fixes

- Update Pinbar submodule with enum cast fixes
- Update Retracement submodule with constructor fixes"

# Push to your fork
git push fork dev
# Or if fork remote not set: git push https://github.com/alphadon/EA31337-strategies.git dev

cd ../..
```

---

## 5. EA31337-strategies-meta Repository

```bash
cd src/strategies-meta

# Ensure on dev branch  
git checkout dev || git checkout -b dev

# Update submodule references
git add Meta_Pattern

# Commit
git commit -m "Update Meta_Pattern submodule: MetaEditor 5370 compatibility fixes

- Update Meta_Pattern with explicit enum cast fixes"

# Push to your fork
git push fork dev
# Or if fork remote not set: git push https://github.com/alphadon/EA31337-strategies-meta.git dev

cd ../..
```

---

## 6. EA31337-classes Repository

```bash
cd src/include/classes

# Ensure on dev branch
git checkout dev || git checkout -b dev

# Stage all modified files
git add Data.struct.h DateTime.struct.h Dict.mqh DictObject.mqh Indicator.mqh \
        Indicator.struct.h Order.struct.h Pattern.struct.h \
        Storage/Objects.h Storage/ObjectsCache.h

# Commit
git commit -m "Fix MetaEditor 5370 compatibility: Multiple type safety improvements

Error Fixes:
- DateTime.struct.h: Add DateTimeEntry operator= for MqlDateTime conversion
- Indicator.mqh: Fix SetParams to use template type TS instead of base class
- Dict.mqh: Add DictIterator constructor from DictIteratorBase
- DictObject.mqh: Add DictObjectIterator constructor from DictIteratorBase
- Storage/Objects.h: Fix parameter type from int to uint
- Storage/ObjectsCache.h: Fix parameter type from int to uint
- Order.struct.h: Add assignment operators for MqlTradeRequest/Result proxies
- Pattern.struct.h: Add 'using' declarations to unhide base class methods

Warning Fixes:
- Data.struct.h: Add constructors for long, string, double types
- Indicator.struct.h: Add constructors for IndicatorDataEntryValue (6 types)

Build 5370 introduced stricter type checking and deprecated initialization patterns.
All changes ensure proper type conversions and initialization via constructors.

Result: 0 errors, 0 warnings (from 101 errors, 104 warnings)"

# Push to your fork
git push fork dev
# Or if fork remote not set: git push https://github.com/alphadon/EA31337-classes.git dev

cd ../../..
```

---

## 7. Main EA31337 Repository

```bash
# Ensure on dev branch
git checkout dev

# Add new documentation
git add METAEDITOR_5370_COMPILATION_FIXES.md

# Update submodule references
git add src/include/classes src/strategies src/strategies-meta

# Commit
git commit -m "Add MetaEditor 5370 compatibility fixes and documentation

- Add comprehensive documentation of all error and warning fixes
- Update submodules to versions with MetaEditor 5370 compatibility
- Document 101 errors and 104 warnings resolved
- Include detailed root cause analysis and solutions
- Add recommendations for future development

Result: Clean compilation with 0 errors, 0 warnings"

# Push to your fork
git push fork dev
# Or if fork remote not set: git push https://github.com/alphadon/EA31337.git dev
```

---

## Verification

After all commits, verify everything is pushed:

```bash
# Check main repo
git log --oneline -5

# Check classes submodule
cd src/include/classes && git log --oneline -2 && cd ../../..

# Check each strategy
cd src/strategies/Pinbar && git log --oneline -2 && cd ../../..
cd src/strategies/Retracement && git log --oneline -2 && cd ../../..
cd src/strategies-meta/Meta_Pattern && git log --oneline -2 && cd ../../..
```

---

## Creating Pull Requests

After pushing to your forks, create pull requests on GitHub:

1. **EA31337-classes**: https://github.com/EA31337/EA31337-classes/compare/dev...alphadon:dev
2. **Strategy-Pinbar**: https://github.com/EA31337/Strategy-Pinbar/compare/dev...alphadon:dev
3. **Strategy-Retracement**: https://github.com/EA31337/Strategy-Retracement/compare/dev...alphadon:dev
4. **Strategy-Meta_Pattern**: https://github.com/EA31337/Strategy-Meta_Pattern/compare/dev...alphadon:dev
5. **EA31337-strategies**: https://github.com/EA31337/EA31337-strategies/compare/dev...alphadon:dev
6. **EA31337-strategies-meta**: https://github.com/EA31337/EA31337-strategies-meta/compare/dev...alphadon:dev
7. **EA31337**: https://github.com/EA31337/EA31337/compare/dev...alphadon:dev

---

## Troubleshooting

### Detached HEAD State

If you're in detached HEAD state:
```bash
git checkout dev || git checkout -b dev
```

### Remote Not Set

If fork remote doesn't exist:
```bash
git remote add fork https://github.com/alphadon/REPO_NAME.git
```

### Authentication Issues

If you have authentication issues, ensure you have:
- GitHub personal access token configured
- SSH keys set up, or
- GitHub CLI authenticated (`gh auth login`)

---

## Summary

Total repositories modified: **7**
- 3 strategy submodules (Pinbar, Retracement, Meta_Pattern)
- 2 parent strategy repos (strategies, strategies-meta)  
- 1 classes submodule
- 1 main repository

Total commits: **7**
Total files modified: **14**

Compilation result: **0 errors, 0 warnings** ✅
