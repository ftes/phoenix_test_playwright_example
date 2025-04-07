defmodule Features.RegisterTest do
  use PhoenixTest.Playwright.Case, async: true
  use MyAppWeb, :verified_routes

  @moduletag :feature

  if !System.get_env("CI"), do: @tag(trace: :open)

  test "register", %{conn: conn} do
    conn
    |> visit(~p"/")
    |> click_link("Register")
    |> assert_has("body .phx-connected")
    |> fill_in("Email", with: "f@ftes.de")
    |> submit()
    |> assert_has("#flash-info", text: "email was sent")
    |> visit(~p"/users/settings")
    |> assert_has("#flash-error", text: "You must log in")
    |> visit(~p"/dev/mailbox")
    |> click_link("Confirmation instructions")
    |> within("iframe >> internal:control=enter-frame", fn conn ->
      conn
      |> click_link("Confirm account")
      |> click_button("Confirm my account")
      |> assert_has("#flash-info", text: "User confirmed")
    end)
    |> visit(~p"/users/settings")
    |> assert_has(".phx-connected")
    |> assert_has("h1", text: "Settings")
  end
end
