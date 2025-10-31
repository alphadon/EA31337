# Testing Guide for MetaEditor 5.00 Build 5370

## Prerequisites

- Windows environment with MetaEditor 5.00 build 5370 installed
- MetaTrader 4 or MetaTrader 5 platform
- This repository cloned with submodules

## Step 1: Setup Environment

### Clone Repository with Submodules

```bash
git clone --recurse-submodules https://github.com/alphadon/EA31337.git
cd EA31337
git checkout dev
```

### Verify Submodule Status

```bash
git submodule status
```

Expected output should show the classes submodule pointing to commit `4c7f9ddc`.

## Step 2: Compile MQL4 Version

1. Open MetaEditor from MetaTrader 4
2. Navigate to **File > Open Data Folder**
3. Go to `MQL4/Experts/` directory
4. Copy the `EA31337` folder there (or create a symbolic link)
5. In MetaEditor, open `EA31337/src/EA31337.mq4`
6. Click **Compile** button or press F7
7. Check for any errors or warnings in the **Errors** tab

### Expected Results

- **No compilation errors**
- **No type-related warnings** about:
  - Assignment operator return types
  - Pointer type mismatches
  - Template instantiation issues

### Common Issues to Watch For

If you see errors like:
- `'void' cannot be converted to 'X*'` - This should now be fixed
- `'unsigned int' cannot be converted to pointer` - This should now be fixed
- `invalid pointer operation` - Check POINTER enum usage

## Step 3: Compile MQL5 Version

1. Open MetaEditor from MetaTrader 5
2. Navigate to **File > Open Data Folder**
3. Go to `MQL5/Experts/` directory
4. Copy the `EA31337` folder there (or create a symbolic link)
5. In MetaEditor, open `EA31337/src/EA31337.mq5`
6. Click **Compile** button or press F7
7. Check for any errors or warnings in the **Errors** tab

### Expected Results

Same as MQL4 - no errors or type-related warnings.

## Step 4: Verify Specific Changes

### Check SimpleRef Operator

Look for any warnings related to:
- `Refs.struct.h` line 66-78 (SimpleRef operator=)
- Assignment operations returning void

### Check GetPointer Usage

Look for any warnings related to:
- `Std.h` line 196 (GetPointer function)
- Pointer size mismatches

### Check Template Instantiations

Look for any warnings in:
- Strategy files using `.Ptr()` methods
- Meta-strategy files using template parameters
- Indicator files with pointer operations

## Step 5: Run Basic Tests

### Test 1: Strategy Tester (Single Strategy)

1. Open Strategy Tester in MetaTrader
2. Select EA31337 (Lite version recommended for testing)
3. Choose a symbol (e.g., EURUSD)
4. Set timeframe to H1
5. Run backtest for 1 month
6. Check for:
   - No runtime errors in the log
   - Strategies initialize correctly
   - Orders can be placed and closed
   - No memory leaks

### Test 2: Multiple Strategies

1. Configure EA to use multiple strategies
2. Run backtest for 1 week
3. Verify:
   - All strategies load correctly
   - Reference counting works properly
   - No crashes or freezes

### Test 3: Indicators

1. Enable custom indicators in the EA
2. Run backtest for 1 week
3. Check:
   - Indicators load and calculate correctly
   - No pointer-related errors
   - Memory management is stable

## Step 6: Check Logs

### MetaEditor Compilation Log

Review the compilation log for:
- Total warnings count (should be minimal)
- Any deprecated function usage
- Type conversion warnings

### MetaTrader Journal

After running tests, check the Journal tab for:
- Initialization errors
- Runtime type errors
- Memory allocation failures

### Expert Log

Check the Expert Advisors log for:
- Strategy loading issues
- Order execution problems
- Indicator calculation errors

## Step 7: Performance Testing

### Memory Usage

Monitor memory usage during:
- EA initialization
- Strategy processing
- Long-running backtests (1+ months)

**Expected**: No memory leaks or excessive growth

### Reference Counting

With verbose logging enabled, verify:
- Objects are created correctly
- References are incremented/decremented properly
- Objects are deleted when no longer needed

### CPU Usage

Compare CPU usage with previous builds:
- Should be similar or better
- No excessive computation from type checking

## Troubleshooting

### If You See Type Errors

1. **Check build version**:
   ```
   Print(__MQLBUILD__);
   ```
   Should return >= 5370

2. **Verify submodule is updated**:
   ```bash
   cd src/include/classes
   git log -1
   ```
   Should show commit `4c7f9ddc`

3. **Clean and rebuild**:
   - Delete all `.ex4` and `.ex5` files
   - Close and reopen MetaEditor
   - Compile again

### If You See Pointer Errors

1. Check that all `.Ptr()` calls use proper dereferencing
2. Verify `CheckPointer()` uses ENUM_POINTER values
3. Look for explicit casts that may need updating

### If You See Template Errors

1. Check template parameter specifications
2. Verify type inference is working correctly
3. Add explicit type parameters if needed

## Reporting Issues

If you encounter compilation errors after these changes:

1. **Document the error**:
   - Full error message
   - File and line number
   - Code snippet showing the issue

2. **Check build information**:
   - MetaEditor build number
   - MetaTrader version
   - Platform (MT4/MT5)

3. **Create an issue** with:
   - Error details
   - Steps to reproduce
   - Your environment info

## Success Criteria

**PASS**: **All tests pass if**:
- EA31337.mq4 compiles without errors
- EA31337.mq5 compiles without errors
- No type-related warnings in compilation log
- Backtests run successfully without crashes
- Memory usage remains stable
- All strategies load and execute properly

## Additional Testing

### Advanced Mode Testing

Test with different EA modes:
- Lite mode
- Advanced mode
- Rider mode

### Strategy-Specific Testing

Test individual strategies:
- AC, AD, ADX strategies
- MA-based strategies
- Oscillator strategies
- Meta-strategies

### Edge Cases

Test edge cases:
- Very short backtests (1 day)
- Very long backtests (1+ years)
- High-frequency timeframes (M1)
- Low-frequency timeframes (W1)

---

**Document Version**: 1.0
**Last Updated**: October 31, 2025
**Compatible With**: MetaEditor 5.00 build 5370+
