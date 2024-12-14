defmodule Features.RegisterTest do
  use PhoenixTest.Playwright.Case, async: true
  use MyAppWeb, :verified_routes

  if !System.get_env("CI"), do: @tag(trace: :open)

  test "register", %{conn: conn} do
    conn
    |> visit(~p"/")
    |> click_link("Register")
    |> assert_has("body .phx-connected")
    |> fill_in("Email", with: "f@ftes.de")
    |> fill_in("Password", with: "passwordpassword")
    |> click_button("Create an account")
    |> assert_has("#flash-info", text: "Account created")
  end
end
