# Quick Start: Compiling with Fusion Markets MetaTrader 5

## Your MetaEditor Installation

**Path**: `C:\Program Files\Fusion Markets MetaTrader 5\MetaEditor64.exe`
**Build**: 5.00.5370 (or compatible)

## Option 1: Using the Batch Script (Recommended)

1. **Open Command Prompt** on your Windows machine (as Administrator if needed)

2. **Navigate to the repository**:
   ```cmd
   cd C:\path\to\EA31337
   ```

3. **Run the compilation script**:
   ```cmd
   compile_5370.bat
   ```

4. **Check the results**:
   - Look for `src/EA31337.ex5` (MQL5 compiled file)
   - Look for `src/EA31337.ex4` (MQL4 compiled file)
   - Review any warnings or errors displayed

## Option 2: Using MetaEditor GUI

### For MQL5:

1. Open **MetaEditor64.exe** from:
   ```
   C:\Program Files\Fusion Markets MetaTrader 5\MetaEditor64.exe
   ```

2. In MetaEditor:
   - Click **File -> Open** (or Ctrl+O)
   - Navigate to your EA31337 repository
   - Open `src\EA31337.mq5`

3. Compile:
   - Click **Compile** button (or press F7)
   - Check the **Errors** tab at the bottom

4. Verify:
   - Should see: `0 error(s), X warning(s)`
   - File `src\EA31337.ex5` should be created

### For MQL4:

1. Open **MetaEditor** from MetaTrader 4 (if you have MT4 installed)

2. Follow the same steps but open `src\EA31337.mq4`

3. Compile and verify `src\EA31337.ex4` is created

## Option 3: Command Line Compilation

Open PowerShell or Command Prompt and run:

### Compile MQL5:
```powershell
& "C:\Program Files\Fusion Markets MetaTrader 5\MetaEditor64.exe" /compile:"C:\path\to\EA31337\src\EA31337.mq5" /log /inc:"C:\path\to\EA31337\src"
```

### Compile MQL4:
```powershell
& "C:\Program Files\Fusion Markets MetaTrader 5\MetaEditor64.exe" /compile:"C:\path\to\EA31337\src\EA31337.mq4" /log /inc:"C:\path\to\EA31337\src"
```

**Note**: Replace `C:\path\to\EA31337` with your actual repository path.

## Expected Results

### Successful Compilation:

```
Compilation successful
0 error(s), 0-5 warning(s)
Result: EA31337.ex5 created (or .ex4 for MQL4)
```

### What to Look For:

OK **GOOD** - Zero errors
OK **GOOD** - Few warnings (deprecation notices are OK)
OK **GOOD** - `.ex5` or `.ex4` file created
X **BAD** - Type conversion errors
X **BAD** - Pointer-related errors
X **BAD** - Assignment operator errors

## Common Build 5370 Issues Fixed

If you had build 5370 before our changes, you might have seen:

- X `'void' cannot be assigned to 'X*'` - **FIXED** in SimpleRef operator=
- X `invalid pointer type` - **FIXED** with size_t GetPointer
- X `type mismatch in assignment` - **FIXED** with proper return types

These should now all compile cleanly!

## Troubleshooting

### Issue: "MetaEditor64.exe not found"

**Solution**: Verify the path exists:
```cmd
dir "C:\Program Files\Fusion Markets MetaTrader 5\MetaEditor64.exe"
```

If not found, update the path in `compile_5370.bat` to your actual installation path.

### Issue: "Include file not found"

**Solution**: Make sure you cloned with submodules:
```bash
git submodule update --init --recursive
```

### Issue: Compilation errors about types

**Solution**:
1. Verify you're on the `dev` branch
2. Check submodule is updated:
   ```bash
   cd src/include/classes
   git log -1
   # Should show commit 4c7f9ddc
   ```

## Next Steps After Successful Compilation

1. **Test in Strategy Tester**:
   - Open MetaTrader 5
   - Press Ctrl+R to open Strategy Tester
   - Select EA31337 from the Expert Advisor dropdown
   - Run a quick backtest

2. **Check Logs**:
   - Open MetaTrader 5 terminal
   - View the Experts tab for any runtime errors
   - Check Journal tab for initialization messages

3. **Report Results**:
   - If compilation succeeds: OK Great! The build 5370 update works!
   - If compilation fails: Create an issue with error details

## Verification Checklist

- [ ] Cloned repository with submodules
- [ ] On `dev` branch with latest changes
- [ ] MetaEditor64.exe path is correct
- [ ] MQL5 compilation completed successfully
- [ ] MQL4 compilation completed successfully (if MT4 available)
- [ ] No type-related errors in compilation log
- [ ] `.ex5` and/or `.ex4` files created
- [ ] Ready for Strategy Tester testing

---

**Your Setup**: Fusion Markets MetaTrader 5
**MetaEditor**: Build 5370
**Status**: Ready to compile OK
