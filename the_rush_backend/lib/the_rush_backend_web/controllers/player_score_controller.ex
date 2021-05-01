defmodule TheRushBackendWeb.PlayerScoreController do
  use TheRushBackendWeb, :controller

  alias TheRushBackend.Scores
  alias TheRushBackend.Scores.PlayerScore

  action_fallback TheRushBackendWeb.FallbackController

  def index(conn, params) do
    player_scores = params |> sanitized_params() |> Scores.list_player_scores()
    total = params |> sanitized_params() |> Scores.count_player_score()

    render(conn, "paginated.json", player_scores: player_scores, pagination: %{total: total})
  end

  def csv(conn, params) do
    player_scores = params |> sanitized_params() |> Scores.list_player_scores(paginate: false)

    data = TheRushBackendWeb.PlayerScoreView.render("csv", %{player_scores: player_scores})
    |> CSV.encode(headers: csv_headers)
    |> Enum.to_list
    |> to_string

    send_download(conn, {:binary, data}, filename: "player_scores.csv")
  end

  defp sanitized_params(params) do
    %{
      "player" => params["player"] || "",
      "sort_desc" => params["sort_desc"] || "false",
      "sort_by" => params["sort_by"] || "player",
      "page" => params["page"] || 1,
      "per_page" => params["per_page"] || 10
    }
  end

  defp csv_headers do
    ["id","Player","Team","Pos","Att","Att/G",
    "Yds","Avg","Yds/G","TD","Lng","1st","1st%","20+","40+","FUM"]
  end

end
