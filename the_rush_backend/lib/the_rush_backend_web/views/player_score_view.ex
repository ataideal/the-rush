defmodule TheRushBackendWeb.PlayerScoreView do
  use TheRushBackendWeb, :view
  alias TheRushBackendWeb.PlayerScoreView

  def render("paginated.json", %{player_scores: player_scores, pagination: pagination}) do
    %{
      data: render_many(player_scores, PlayerScoreView, "player_score.json"),
      pagination: pagination
    }
  end

  def render("csv", %{player_scores: player_scores}) do
    render_many(player_scores, PlayerScoreView, "player_score.csv")
  end

  def render("player_score.csv", %{player_score: player_score}) do
    %{"id" => player_score.id,
      "Player" => player_score.player,
      "Team" => player_score.team,
      "Pos" => player_score.pos,
      "Att" => player_score.att,
      "Att/G" => player_score.att_g,
      "Yds" => player_score.yds,
      "Avg" => player_score.avg,
      "Yds/G" => player_score.yds_g,
      "TD" => player_score.td,
      "Lng" => Float.to_string(player_score.lng) <> (player_score.lng_t || ""),
      "1st" => player_score.first,
      "1st%" => player_score.first_percent,
      "20+" => player_score.twenty_plus,
      "40+" => player_score.forty_plus,
      "FUM" => player_score.fum}
  end
  
  def render("player_score.json", %{player_score: player_score}) do
    %{id: player_score.id,
      player: player_score.player,
      team: player_score.team,
      pos: player_score.pos,
      att: player_score.att,
      att_g: player_score.att_g,
      yds: player_score.yds,
      avg: player_score.avg,
      yds_g: player_score.yds_g,
      td: player_score.td,
      lng: Float.to_string(player_score.lng) <> (player_score.lng_t || ""),
      lng_t: player_score.lng_t,
      first: player_score.first,
      first_percent: player_score.first_percent,
      twenty_plus: player_score.twenty_plus,
      forty_plus: player_score.forty_plus,
      fum: player_score.fum}
  end
end
