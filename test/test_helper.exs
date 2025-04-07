ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(MyApp.Repo, :manual)

if System.get_env("MIX_TEST_ENV") == "feature" do
  Application.put_env(:my_app, MyApp.Mailer, adapter: Swoosh.Adapters.Local)
end

Application.put_env(:phoenix_test, :base_url, MyAppWeb.Endpoint.url())
