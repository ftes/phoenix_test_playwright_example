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
    |> click_button("Create an account")
    |> assert_has("#flash-info", text: "email was sent")
    |> visit(~p"/dev/mailbox")
    |> click_link("log-in")
    |> click_button("Confirm and stay logged in")
    |> assert_has("#flash-info", text: "User confirmed")
    |> visit(~p"/users/settings")
    |> assert_has(".phx-connected")
    |> assert_has("h1", text: "Settings")
  end
end
