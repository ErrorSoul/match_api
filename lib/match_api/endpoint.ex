defmodule MatchApi.Endpoint do
  use Plug.Router
  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  plug(:dispatch)

  post "/score/:user_id" do
    resp = increment_score(user_id) |> Poison.encode!

    conn
    |> json
    |> send_resp(200, resp)
  end

  get "/score/:user_id" do
    resp = get_score(user_id) |> Poison.encode!

    conn
    |> json
    |> send_resp(200, resp)
  end

  match _ do
    resp = not_found() |> Poison.encode!

    conn
    |> json
    |> send_resp(404, resp)
  end

  defp increment_score(user_id) do
    %{
      user_id: user_id,
      score: MatchApi.Redis.increment(user_id)
    }
  end

  defp get_score(user_id) do
    %{
      user_id: user_id,
      score: MatchApi.Redis.get(user_id)
    }
  end

  defp not_found(), do: %{error: "Not found"}

  defp json(conn) do
    Plug.Conn.put_resp_header(conn, "content-type", "application/json")
  end
end