# Submodule Fork Instructions

## Classes Submodule Changes

The EA31337-classes submodule has 7 commits with MetaEditor 5.00 build 5370 compatibility fixes.

### Option 1: Create Fork and Apply Patch

1. **Fork the repository on GitHub:**
   - Go to <https://github.com/EA31337/EA31337-classes>
   - Click "Fork" button
   - Fork to alphadon account

2. **Add fork remote and push:**

   ```bash
   cd src/include/classes
   git remote add fork https://github.com/alphadon/EA31337-classes.git
   git push fork dev
   ```

### Option 2: Apply Patch File

If you prefer to apply the changes later:

```bash
cd src/include/classes
git checkout -b dev
git am < ../../classes-build5370-fixes.patch
```

### Commits Included

1. `4c7f9ddc` - Update type references for MetaEditor 5.00 build 5370 compatibility
2. `f297953e` - Fix SetParams parameter type for build 5370 compatibility
3. `949a885f` - Fix: Change position variable from int to unsigned int
4. `d1d8eb8e` - Fix: Add const qualifier to MqlDateTime reference parameters
5. `0aa6984b` - Fix: Add const qualifiers to all MqlDateTime/DateTimeEntry parameters
6. `806e9c5f` - Fix: Replace struct assignment with explicit field copying
7. `3dc416c5` - Fix: Avoid operator= method hiding with explicit field copying

### Files Modified

- `Refs.struct.h` - SimpleRef operator= return type, GetPointer size_t
- `Indicator.mqh` - SetParams const parameter
- `Dict.mqh` - Position variable unsigned int
- `DictStruct.mqh` - Position variable unsigned int
- `DateTime.struct.h` - Const references, explicit field copying
- `DateTime.mqh` - Const references, explicit field copying
- `Market.struct.h` - Const references

## Current State

The main EA31337 repository (alphadon/EA31337) has been updated and pushed with:

- All classes submodule reference updates
- Compilation scripts (compile_5370.bat, compile_5370_verbose.bat, sync_and_compile.bat)
- Documentation updates
- Updated .gitignore

The classes submodule changes are LOCAL only and need to be pushed to a fork once created.
