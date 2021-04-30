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

  def create(conn, %{"player_score" => player_score_params}) do
    with {:ok, %PlayerScore{} = player_score} <- Scores.create_player_score(player_score_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.player_score_path(conn, :show, player_score))
      |> render("show.json", player_score: player_score)
    end
  end

  defp sanitized_params(params) do
    params
  end
end
