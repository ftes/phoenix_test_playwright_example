defmodule Features.RegisterTest do
  @test_suites String.to_integer(System.get_env("T"))
  @iterations_within_test 10

  use PlaywrightNoSandboxCase,
    async: true,
    parameterize: Enum.map(1..@test_suites, &%{index: &1})

  use MyAppWeb, :verified_routes

  test "register", %{conn: conn} do
    for _ <- 1..@iterations_within_test do
      email = "f#{System.unique_integer() + :os.system_time(:microsecond)}@ftes.de"

      conn
      |> visit(~p"/")
      |> click_link("Register")
      |> assert_has(".phx-connected")
      |> fill_in("Email", with: email)
      |> click_button("Create an account")
      |> assert_has("#flash-info", text: "email was sent")
      |> visit(~p"/dev/mailbox")
      |> click_link("Confirmation instructions #{email}")
      |> click_link("log-in")
      |> assert_has(".phx-connected")
      |> click_button("Confirm and stay logged in")
      |> assert_has("#flash-info", text: "User confirmed")
      |> visit(~p"/users/settings")
      |> assert_has(".phx-connected")
      |> assert_has("h1", text: "Settings")
      |> click_link("Log out")
    end
  end
end
