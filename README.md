[![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/ftes/phoenix_test_playwright_example/elixir.yml)](https://github.com/ftes/phoenix_test_playwright_example/actions)

# PhoenixTest Playwright example

To run the feature test:

```
mix setup
mix test test/features
```

The Playwright trace viewer should automatically open.
If it doesn't, drop the `tmp/*.zip` file into [trace.playwright.dev](https://trace.playwright.dev).

## Regeneration procedure

This project maintains a clean git history showing each generation step.
To regenerate from scratch:

```sh
mix archive.install hex phx_new
mix phx.new my_app --install
cd my_app && git init && git add -A && git commit -m "mix phx.new my_app"

mix phx.gen.auth Accounts User users --live
mix deps.get
git add -A && git commit -m "mix phx.gen.auth Accounts User users --live"

# Apply PhoenixTestPlaywright changes (see commit diff)
# Apply Tidewave changes (see commit diff)
```
