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

  defp sanitized_params(params) do
    params
  end
end
