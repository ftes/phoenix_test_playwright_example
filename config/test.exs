import Config

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :my_app, MyApp.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "my_app_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :my_app, MyAppWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "jsn/1/91hihxhFlb/ynE1r2Y3uIk1LZhSMyYJghMaBFowokOQOWU0taPLmaOOxSR",
  server: false

# In test we don't send emails
# config :my_app, MyApp.Mailer, adapter: Swoosh.Adapters.Local

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true

config :my_app,
  sql_sandbox: false,
  dev_routes: true

config :phoenix_test,
  endpoint: MyAppWeb.Endpoint,
  otp_app: :my_app,
  playwright: [
    # trace failed tests in CI via re-run
    trace: System.get_env("PLAYWRIGHT_TRACE", "false") in ~w(t true),
    trace_dir: "tmp",
    timeout: 10_000,
    browser_pool_size: String.to_integer(System.get_env("CONCURRENCY"))
  ]
