# EA31337 Symbol Configuration Guide

## How Symbols Work in EA31337

EA31337 automatically adapts to the symbol of the chart it's attached to using `_Symbol`. The EA reads symbol properties (spread, digits, tick size, margin requirements) and adjusts its trading logic accordingly.

## Supported Symbol Types

### Forex Pairs (33 pairs)
**Majors:** EURUSD, GBPUSD, USDJPY, USDCHF, AUDUSD, NZDUSD, USDCAD  
**Crosses:** EURJPY, GBPJPY, EURGBP, AUDCAD, AUDCHF, AUDJPY, AUDNZD, CADCHF, CADJPY, CHFJPY, EURAUD, EURCAD, EURCHF, EURNOK, EURNZD, EURSEK, GBPAUD, GBPCAD, GBPCHF, GBPNZD, NZDCAD, NZDCHF, NZDJPY, USDNOK, USDSEK, USDSGD

### Metals (7 pairs)
XAUUSD (Gold), XAGUSD (Silver), XAUEUR, XAUAUD, XPTUSD (Platinum), XPDUSD (Palladium), XAGEUR

### Energy (3 pairs)
XTIUSD (Crude Oil/WTI), XBRUSD (Brent Oil), XNGUSD (Natural Gas)

### Cryptocurrencies (27 pairs)
BTCUSD, ETHUSD, LTCUSD, XRPUSD, BTCEUR, ETHBTC, ETCUSD, EOSUSD, DSHUSD, ETHRUB, EMCUSD, XMRUSD, ZECUSD, and more

### Indices (10 symbols)
SP500m, ND100m, UK100, GDAXIm, FCHI40, NI225, AUS200, HSI50, SPN35, STOX50

## Configuration Methods

### Method 1: Universal Configuration (Recommended for Beginners)

Use the default Advanced edition settings which work across most symbols:

**File:** `src/include/common/advanced/inputs.mqh`

```cpp
// Default configuration works for most Forex pairs
input ENUM_STRATEGY Strategy_M15 = STRAT_META_TREND;
input ENUM_STRATEGY Strategy_M30 = STRAT_META_TREND;
input ENUM_STRATEGY Strategy_H1 = STRAT_META_PIVOT;
input ENUM_STRATEGY Strategy_H4 = STRAT_ICHIMOKU;

// Risk management (adjust based on symbol volatility)
input float EA_Risk_MarginMax = 3.4f;        // Max margin to risk (in %)
input float EA_MaxSpread = 4.0f;             // Max spread (in pips)
input float EA_OrderCloseLoss = 280;         // Stop loss (in pips)
input float EA_OrderCloseProfit = 120;       // Take profit (in pips)
```

### Method 2: Symbol-Specific Parameter Sets (.set files)

Create custom .set files for different symbol categories:

**Example: EURUSD.set (Low Volatility Forex)**
```
EA_Risk_MarginMax=3.0
EA_MaxSpread=2.0
EA_OrderCloseLoss=200
EA_OrderCloseProfit=100
Strategy_M15=STRAT_MA_TREND
Strategy_M30=STRAT_MACD
Strategy_H1=STRAT_RSI
Strategy_H4=STRAT_ICHIMOKU
```

**Example: XAUUSD.set (High Volatility Metal)**
```
EA_Risk_MarginMax=2.0
EA_MaxSpread=10.0
EA_OrderCloseLoss=500
EA_OrderCloseProfit=300
Strategy_M15=STRAT_META_TREND
Strategy_M30=STRAT_ATR_MA_TREND
Strategy_H1=STRAT_AWESOME
Strategy_H4=STRAT_BANDS
```

**Example: BTCUSD.set (Very High Volatility Crypto)**
```
EA_Risk_MarginMax=1.5
EA_MaxSpread=50.0
EA_OrderCloseLoss=1000
EA_OrderCloseProfit=800
Strategy_M15=STRAT_ATR
Strategy_M30=STRAT_DEMARKER
Strategy_H1=STRAT_RSI
Strategy_H4=STRAT_MOMENTUM
```

### Method 3: Symbol Type Detection in Code

For advanced users, you can detect symbol type and adjust parameters programmatically:

**File:** `src/include/ea.h` (add to EA initialization)

```cpp
// Detect symbol type and adjust parameters
string symbol = _Symbol;
if (StringFind(symbol, "XAU") >= 0 || StringFind(symbol, "XAG") >= 0) {
    // Metal configuration
    EA_MaxSpread = 10.0;
    EA_OrderCloseLoss = 500;
    EA_OrderCloseProfit = 300;
}
else if (StringFind(symbol, "BTC") >= 0 || StringFind(symbol, "ETH") >= 0) {
    // Crypto configuration
    EA_MaxSpread = 50.0;
    EA_OrderCloseLoss = 1000;
    EA_OrderCloseProfit = 800;
}
else if (StringFind(symbol, "USD") >= 0 || StringFind(symbol, "EUR") >= 0) {
    // Forex configuration
    EA_MaxSpread = 4.0;
    EA_OrderCloseLoss = 280;
    EA_OrderCloseProfit = 120;
}
```

## Recommended Strategy Configurations by Symbol Type

### Forex Majors (EURUSD, GBPUSD, USDJPY)
**Characteristics:** Low-medium volatility, tight spreads, high liquidity
**Best Strategies:**
- M15: STRAT_MA_TREND, STRAT_META_TREND
- M30: STRAT_MACD, STRAT_RSI
- H1: STRAT_META_PIVOT, STRAT_ICHIMOKU
- H4: STRAT_BANDS, STRAT_SAR

**Parameters:**
- MaxSpread: 2-4 pips
- Stop Loss: 150-250 pips
- Take Profit: 80-120 pips

### Gold (XAUUSD)
**Characteristics:** High volatility, wider spreads, trending
**Best Strategies:**
- M15: STRAT_ATR_MA_TREND, STRAT_META_TREND
- M30: STRAT_DEMARKER, STRAT_AWESOME
- H1: STRAT_BANDS, STRAT_ENVELOPES
- H4: STRAT_ICHIMOKU, STRAT_SAR

**Parameters:**
- MaxSpread: 8-15 pips
- Stop Loss: 400-600 pips
- Take Profit: 250-400 pips

### Cryptocurrencies (BTCUSD, ETHUSD)
**Characteristics:** Very high volatility, wide spreads, 24/7 trading
**Best Strategies:**
- M15: STRAT_ATR, STRAT_MOMENTUM
- M30: STRAT_RSI, STRAT_DEMARKER
- H1: STRAT_AWESOME, STRAT_BANDS
- H4: STRAT_MACD, STRAT_CCI

**Parameters:**
- MaxSpread: 30-100 pips
- Stop Loss: 800-1500 pips
- Take Profit: 500-1000 pips

### Indices (SP500m, ND100m)
**Characteristics:** Medium volatility, trading hours restrictions
**Best Strategies:**
- M15: STRAT_META_TREND, STRAT_MA_TREND
- M30: STRAT_MACD, STRAT_RSI
- H1: STRAT_BANDS, STRAT_ENVELOPES
- H4: STRAT_ICHIMOKU, STRAT_SAR

**Parameters:**
- MaxSpread: 5-10 pips
- Stop Loss: 300-500 pips
- Take Profit: 200-350 pips

## Testing Different Symbols

### Using Strategy Tester in MetaTrader

1. **Compile the EA** for your chosen edition:
   ```powershell
   .\compile_with_edition.ps1
   ```

2. **Open Strategy Tester** (Ctrl+R in MT5)

3. **Select Symbol:** Choose the symbol you want to test
   - EURUSD for Forex
   - XAUUSD for Metals
   - BTCUSD for Crypto

4. **Load Parameters:** 
   - Use .set file: File → Open → Select your symbol-specific .set file
   - Or manually adjust parameters in the Inputs tab

5. **Run Backtest:** Test different periods (1 month, 3 months, 1 year)

### Multi-Symbol Testing

To run the same EA on multiple symbols simultaneously:

1. Compile the EA once
2. Open multiple charts (one per symbol)
3. Attach `EA31337-Advanced.ex5` to each chart
4. Load appropriate .set file for each symbol
5. Each instance runs independently with its own magic number range

**Tip:** Use different magic number ranges to distinguish orders:
- EURUSD: Magic = 31337
- XAUUSD: Magic = 41337
- GBPUSD: Magic = 51337

## Parameter Optimization by Symbol

### Key Parameters to Optimize

**For All Symbols:**
- `EA_LotSize` - Position sizing
- `EA_Risk_MarginMax` - Maximum margin exposure
- `EA_MaxSpread` - Spread filter
- `EA_OrderCloseLoss` - Stop loss distance
- `EA_OrderCloseProfit` - Take profit distance

**Symbol-Specific:**
- **Volatile Symbols** (Gold, Crypto): Increase stop loss, reduce lot size
- **Low-Spread Symbols** (Major Forex): Tighter stops, higher frequency
- **Trending Symbols**: Use trend-following strategies (MA, SAR, Ichimoku)
- **Ranging Symbols**: Use oscillators (RSI, CCI, Stochastic)

### Using Optimization Sets

The EA includes pre-configured optimization sets in `sets/optimize/Advanced/`:

```
sets/optimize/Advanced/
├── risk/          # Risk management parameters
│   └── MarginMax.set
├── soft/          # Signal filtering
│   └── EA_SignalOpenFilterMethod.set
├── stops/         # Stop loss configurations
│   ├── EA_Stops_M1.set
│   ├── EA_Stops_M15.set
│   └── EA_Stops_M30.set
└── tf/            # Timeframe strategies
    ├── Strategy_M1.set
    ├── Strategy_M15.set
    └── Strategy_M30.set
```

Load these in Strategy Tester → Optimization mode to find optimal parameters for your symbol.

## Best Practices

1. **Start Conservative:** Use lower leverage and risk percentage when testing new symbols
2. **Spread Awareness:** Set `EA_MaxSpread` to prevent trading during high-spread periods
3. **Symbol Characteristics:** Study the symbol's typical daily range, volatility, and trading hours
4. **Backtest First:** Always backtest for at least 3-6 months before live trading
5. **Multiple Timeframes:** Use different strategies on different timeframes for diversification
6. **Risk Management:** Never risk more than 2-3% of account per symbol
7. **Correlation:** Be aware of correlated symbols (e.g., EURUSD and USDCHF move inversely)

## Quick Start Examples

### Example 1: Conservative Forex Trading (EURUSD)
```
Edition: Advanced
Symbol: EURUSD
Timeframe: Attach to any (EA uses multiple timeframes internally)
Risk: 2.0%
Max Spread: 2.0 pips
Strategies: MA_TREND (M15), MACD (M30), RSI (H1), ICHIMOKU (H4)
```

### Example 2: Aggressive Gold Trading (XAUUSD)
```
Edition: Advanced
Symbol: XAUUSD
Risk: 1.5%
Max Spread: 12.0 pips
Strategies: ATR_MA_TREND (M15), AWESOME (M30), BANDS (H1), SAR (H4)
```

### Example 3: Crypto Scalping (BTCUSD)
```
Edition: Advanced
Symbol: BTCUSD
Risk: 1.0%
Max Spread: 50.0 pips
Strategies: ATR (M15), RSI (M30), MOMENTUM (H1), CCI (H4)
```

## Advanced: Multi-Symbol Portfolio

For professional traders, run EA31337 on a portfolio of symbols:

**Conservative Forex Portfolio:**
- EURUSD (30% allocation)
- GBPUSD (25% allocation)
- USDJPY (25% allocation)
- AUDUSD (20% allocation)

**Diversified Portfolio:**
- EURUSD (25% - Forex)
- XAUUSD (25% - Metal)
- XTIUSD (20% - Energy)
- BTCUSD (15% - Crypto)
- SP500m (15% - Index)

Each symbol runs with its own optimized parameters and risk settings.

## Troubleshooting

**Q: EA not opening trades on [symbol]?**
- Check `EA_MaxSpread` - may be too restrictive
- Verify symbol is available in your broker
- Check trading hours for indices/stocks

**Q: Too many losses on [symbol]?**
- Backtest with historical data first
- Adjust stop loss for symbol's volatility
- Reduce risk percentage
- Try different strategy combinations

**Q: Different results between symbols?**
- Normal - each symbol has unique characteristics
- Optimize parameters specifically for each symbol
- Some symbols trend better, others range better

## Resources

- Strategy List: `src/strategies/enum.h`
- Symbol Definitions: `src/include/classes/SymbolInfo.enum.symbols.h`
- Input Parameters: `src/include/common/advanced/inputs.mqh`
- Optimization Sets: `sets/optimize/Advanced/`

---

**Note:** Always test configurations in demo account before live trading!
