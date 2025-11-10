defmodule MyAppWeb.QueriesLive do
  use MyAppWeb, :live_view

  alias MyApp.Repo

  @impl true
  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-2xl p-8">
      <h1 class="text-3xl font-bold mb-8">Database Queries</h1>

      <div class="space-y-8">
        <div class="card bg-base-100 shadow-xl">
          <div class="card-body">
            <h2 class="card-title">now()</h2>
            <p class="text-lg font-mono"><%= @now %></p>
          </div>
        </div>

        <div class="card bg-base-100 shadow-xl">
          <div class="card-body">
            <h2 class="card-title">random()</h2>
            <.async_result assign={@random}>
              <div id="random_value" :if={rn = @random.ok? && @random.result}>{rn}</div>
              <:loading>
                <div class="loading loading-spinner loading-md"></div>
              </:loading>
              <:failed :let={reason}>
                <p class="text-error">Failed to load: <%= reason %></p>
              </:failed>
            </.async_result>
          </div>
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, results} = Repo.query("SELECT now();")
    [[now]] = results.rows

    socket =
      socket
      |> assign(:now, now)
      |> assign_async(:random, fn -> fetch_random_number() end)

    {:ok, socket}
  end


  defp fetch_random_number() do
    # Maybe pretend this is slow
    Process.sleep(query_delay())
    {:ok, results} = Repo.query("SELECT random();")
    [[random]] = results.rows
    {:ok, %{random: random}}
  end

  defp query_delay do
    with delay_str <- System.get_env("QUERY_DELAY"),
         true <- is_binary(delay_str),
         {delay, ""} <- Integer.parse(delay_str) do
      delay
    else
      _ -> 0
    end
  end
end
