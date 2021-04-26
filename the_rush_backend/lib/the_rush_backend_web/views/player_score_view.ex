defmodule TheRushBackendWeb.PlayerScoreView do
  use TheRushBackendWeb, :view
  alias TheRushBackendWeb.PlayerScoreView

  def render("index.json", %{player_scores: player_scores}) do
    %{data: render_many(player_scores, PlayerScoreView, "player_score.json")}
  end

  def render("show.json", %{player_score: player_score}) do
    %{data: render_one(player_score, PlayerScoreView, "player_score.json")}
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
      lng: player_score.lng,
      lng_t: player_score.lng_t,
      first: player_score.first,
      first_percent: player_score.first_percent,
      twenty_plus: player_score.twenty_plus,
      forty_plus: player_score.forty_plus,
      fum: player_score.fum}
  end
end
