playwright fullyParallel=true
for comparability: external standalone `MIX_ENV=prod mix phx.server`, no ecto sandboxing
14 cores (Apple M4 Pro, 10 regular, 4 efficiency)
- drop and restart database and restarted phoenix inbetween (getting slower)

```
MIX_ENV=prod mix ecto.reset
export TEST_SUITES=1
export WORKERS=1
time (cd assets; npx playwright test --workers $WORKERS)
MIX_ENV=prod mix ecto.reset
time mix test test/features/register_test.exs --max-cases $WORKERS
```

| workers (max) | tests suites | Playwright JS (s) | PheonixTestPlaywright (s) |
-------------------------------------
|  1 |   1 |   6.8 |   6.3 |
|  1 |   2 |  12.2 |  11.7 |
|  1 |   4 |  23.5 |  22.7 |
|  1 |   8 |  47.5 |  46.1 |
|  2 |   2 |   6.7 |   6.6 |
|  2 |   4 |  12.6 |  12.3 |
|  2 |   8 |  23.2 |  22.7 |
|  2 |  16 |  43.7 |  43.3 |
|  4 |   4 |   7.1 |   6.8 |
|  4 |   8 |  13.5 |  13.6 |
|  4 |  16 |  24.9 |  24.8 |
|  4 |  32 |  44.7 |  46.0 |
|  8 |   8 |   7.3 |   7.1 |
|  8 |  16 |  13.6 |  13.7 |
|  8 |  32 |  23.8 |  24.8 |
|  8 |  64 |  47.0 |  47.4 |
| 10 | 128 |  81.0 |  82.2 |
| 14 | 128 |  68.1 |  69.9 |
| 16 |  16 |   9.5 |   9.4 |
| 16 |  32 |  14.7 |  16.7 |
| 16 |  64 |  29.0 |  30.1 |
| 16 | 128 |  59.0 |  63.4 |
| 16 | 256 | 134.0 | 145.1 |
| 20 | 128 |  58.9 |  65.3 |
| 28 | 128 |  68.0 | 63.6 |
| 32 |  32 |  18.0 |  16.5 |
| 32 |  64 |  35.5 |  30.2 |
| 32 | 128 |  81.8 |  65.0 |
