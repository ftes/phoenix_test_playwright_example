ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(MyApp.Repo, :manual)
Application.put_env(:phoenix_test, :base_url, "http://localhost:4000")
