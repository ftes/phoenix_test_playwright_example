[![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/ftes/phoenix_test_playwright_example/elixir.yml)](https://github.com/ftes/phoenix_test_playwright_example/actions)

# PhoenixTest Playwright example

To run the feature test:

```
npm --prefix assets i
npm --prefix assets exec playwright install chromium --with-deps
mix deps.get
mix assets.build

mix test test/features
```

The Playwright trace viewer should automatically open.
If it doesn't, drop the `tmp/*.zip` file into [trace.playwright.dev](https://trace.playwright.dev).
