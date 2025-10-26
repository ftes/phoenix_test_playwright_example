ExUnit.start()

{:ok, _} =
  Supervisor.start_link(
    [
      {Registry, keys: :unique, name: PhoenixTest.Playwright.BrowserPool.Registry},
      {DynamicSupervisor,
       name: PhoenixTest.Playwright.BrowserPool.Supervisor, strategy: :one_for_one},
      {Phoenix.PubSub, name: PhoenixTest.PubSub}
    ],
    strategy: :one_for_one
  )

# Ecto.Adapters.SQL.Sandbox.mode(MyApp.Repo, :manual)
Application.put_env(:phoenix_test, :base_url, "http://localhost:4000")
