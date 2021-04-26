defmodule TheRushBackendWeb.PlayerScoreController do
  use TheRushBackendWeb, :controller

  alias TheRushBackend.Scores
  alias TheRushBackend.Scores.PlayerScore

  action_fallback TheRushBackendWeb.FallbackController

  def index(conn, _params) do
    player_scores = Scores.list_player_scores()
    render(conn, "index.json", player_scores: player_scores)
  end

  def create(conn, %{"player_score" => player_score_params}) do
    with {:ok, %PlayerScore{} = player_score} <- Scores.create_player_score(player_score_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.player_score_path(conn, :show, player_score))
      |> render("show.json", player_score: player_score)
    end
  end

  def show(conn, %{"id" => id}) do
    player_score = Scores.get_player_score!(id)
    render(conn, "show.json", player_score: player_score)
  end

  def update(conn, %{"id" => id, "player_score" => player_score_params}) do
    player_score = Scores.get_player_score!(id)

    with {:ok, %PlayerScore{} = player_score} <- Scores.update_player_score(player_score, player_score_params) do
      render(conn, "show.json", player_score: player_score)
    end
  end

  def delete(conn, %{"id" => id}) do
    player_score = Scores.get_player_score!(id)

    with {:ok, %PlayerScore{}} <- Scores.delete_player_score(player_score) do
      send_resp(conn, :no_content, "")
    end
  end
end
