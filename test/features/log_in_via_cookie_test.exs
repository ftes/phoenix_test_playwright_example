defmodule Features.LogInViaCookieTest do
  use PhoenixTest.Playwright.Case, async: true
  use MyAppWeb, :verified_routes

  import MyApp.AccountsFixtures

  alias MyApp.Accounts

  @moduletag :feature

  test "already logged in", %{conn: conn} do
    user = unconfirmed_user_fixture()
    token = Accounts.generate_user_session_token(user)

    conn
    |> add_session_cookie([value: %{user_token: token}], MyAppWeb.Endpoint.session_options())
    |> visit(~p"/users/settings")
    |> assert_has(".phx-connected")
    |> assert_has("h1", text: "Settings")
  end
end
