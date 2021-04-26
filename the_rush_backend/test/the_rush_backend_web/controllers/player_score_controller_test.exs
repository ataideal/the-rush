defmodule TheRushBackendWeb.PlayerScoreControllerTest do
  use TheRushBackendWeb.ConnCase

  alias TheRushBackend.Scores
  alias TheRushBackend.Scores.PlayerScore

  @create_attrs %{
    att: 42,
    att_g: 120.5,
    avg: 120.5,
    first: 42,
    first_percent: 120.5,
    forty_plus: 42,
    fum: 42,
    lng: 120.5,
    player: "some player",
    pos: "some pos",
    td: 42,
    team: "some team",
    twenty_plus: 42,
    yds: 120.5,
    yds_g: 120.5
  }
  @update_attrs %{
    att: 43,
    att_g: 456.7,
    avg: 456.7,
    first: 43,
    first_percent: 456.7,
    forty_plus: 43,
    fum: 43,
    lng: 456.7,
    player: "some updated player",
    pos: "some updated pos",
    td: 43,
    team: "some updated team",
    twenty_plus: 43,
    yds: 456.7,
    yds_g: 456.7
  }
  @invalid_attrs %{att: nil, att_g: nil, avg: nil, first: nil, first_percent: nil, forty_plus: nil, fum: nil, lng: nil, player: nil, pos: nil, td: nil, team: nil, twenty_plus: nil, yds: nil, yds_g: nil}

  def fixture(:player_score) do
    {:ok, player_score} = Scores.create_player_score(@create_attrs)
    player_score
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all player_scores", %{conn: conn} do
      conn = get(conn, Routes.player_score_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create player_score" do
    test "renders player_score when data is valid", %{conn: conn} do
      conn = post(conn, Routes.player_score_path(conn, :create), player_score: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.player_score_path(conn, :show, id))

      assert %{
               "id" => id,
               "att" => 42,
               "att_g" => 120.5,
               "avg" => 120.5,
               "first" => 42,
               "first_percent" => 120.5,
               "forty_plus" => 42,
               "fum" => 42,
               "lng" => "some lng",
               "player" => "some player",
               "pos" => "some pos",
               "td" => 42,
               "team" => "some team",
               "twenty_plus" => 42,
               "yds" => 120.5,
               "yds_g" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.player_score_path(conn, :create), player_score: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update player_score" do
    setup [:create_player_score]

    test "renders player_score when data is valid", %{conn: conn, player_score: %PlayerScore{id: id} = player_score} do
      conn = put(conn, Routes.player_score_path(conn, :update, player_score), player_score: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.player_score_path(conn, :show, id))

      assert %{
               "id" => id,
               "att" => 43,
               "att_g" => 456.7,
               "avg" => 456.7,
               "first" => 43,
               "first_percent" => 456.7,
               "forty_plus" => 43,
               "fum" => 43,
               "lng" => "some updated lng",
               "player" => "some updated player",
               "pos" => "some updated pos",
               "td" => 43,
               "team" => "some updated team",
               "twenty_plus" => 43,
               "yds" => 456.7,
               "yds_g" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, player_score: player_score} do
      conn = put(conn, Routes.player_score_path(conn, :update, player_score), player_score: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete player_score" do
    setup [:create_player_score]

    test "deletes chosen player_score", %{conn: conn, player_score: player_score} do
      conn = delete(conn, Routes.player_score_path(conn, :delete, player_score))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.player_score_path(conn, :show, player_score))
      end
    end
  end

  defp create_player_score(_) do
    player_score = fixture(:player_score)
    %{player_score: player_score}
  end
end
