defmodule TheRushBackendWeb.PlayerScoreControllerTest do
  use TheRushBackendWeb.ConnCase

  alias TheRushBackend.Scores

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

  @default_player_score_json %{
    "att" => 42,
    "att_g" => 120.5,
    "avg" => 120.5,
    "first" => 42,
    "first_percent" => 120.5,
    "forty_plus" => 42,
    "fum" => 42,
    "id" => 1,
    "lng" => "120.5",
    "lng_t" => nil,
    "player" => "some player",
    "pos" => "some pos",
    "td" => 42,
    "team" => "some team",
    "twenty_plus" => 42,
    "yds" => 120.5,
    "yds_g" => 120.5
  }

  @default_filters %{"player" => "","sort_by" => "player","sort_desc" => "false","per_page" => 10,"page" => 1}

  def fixture(:player_score, opts) do
    {:ok, player_score} = opts |> Enum.into(@create_attrs) |> Scores.create_player_score()
    player_score
  end

  def fixture(:filter, opts) do
    opts |> Enum.into(@default_filters)
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "when player_scores is empty list returns empty array and total 0", %{conn: conn} do

      conn = get(conn, Routes.player_score_path(conn, :index), fixture(:filter, %{}))
      assert json_response(conn, 200)["data"] == []
      assert json_response(conn, 200)["pagination"] == %{"total"=> 0}
    end

    test "when player_scores has users returns array ordered by name and total", %{conn: conn} do
      player_score = fixture(:player_score, %{})
      player_score_2 = fixture(:player_score, %{player: "another player"})
      conn = get(conn, Routes.player_score_path(conn, :index), fixture(:filter, %{}))
      assert json_response(conn, 200)["data"] == [
        %{"id" => player_score_2.id, "player" => player_score_2.player} |> Enum.into(@default_player_score_json),
        %{"id" => player_score.id} |> Enum.into(@default_player_score_json)
      ]
      assert json_response(conn, 200)["pagination"] == %{"total"=> 2}
    end

    test "when player_scores filter by name returns array ordered by name and filtered and total", %{conn: conn} do
      fixture(:player_score, %{})
      player_score_2 = fixture(:player_score, %{player: "another player"})
      conn = get(conn, Routes.player_score_path(conn, :index), fixture(:filter, %{"player"=> "another"}))
      assert json_response(conn, 200)["data"] == [
        %{"id" => player_score_2.id, "player" => player_score_2.player} |> Enum.into(@default_player_score_json)
      ]
      assert json_response(conn, 200)["pagination"] == %{"total"=> 1}
    end

    test "when player_scores order by desc lng returns array ordered by lng", %{conn: conn} do
      player_score = fixture(:player_score, %{})
      player_score_2 = fixture(:player_score, %{lng: 200.0})
      conn = get(conn, Routes.player_score_path(conn, :index),
                  fixture(:filter, %{"sort_by"=>"lng", "sort_desc" => "true" }))
      assert json_response(conn, 200)["data"] == [
        %{"id" => player_score_2.id, "lng" => Float.to_string(player_score_2.lng)} |> Enum.into(@default_player_score_json),
        %{"id" => player_score.id} |> Enum.into(@default_player_score_json)
      ]
      assert json_response(conn, 200)["pagination"] == %{"total"=> 2}
    end

    test "filter page 2 returns array with page 2", %{conn: conn} do
      player_score = fixture(:player_score, %{})
      fixture(:player_score, %{player: "a"})
      conn = get(conn, Routes.player_score_path(conn, :index),fixture(:filter, %{"page"=>2, "per_page" => 1 }))
      assert json_response(conn, 200)["data"] == [
        %{"id" => player_score.id} |> Enum.into(@default_player_score_json)
      ]
      assert json_response(conn, 200)["pagination"] == %{"total"=> 2}
    end

  end
end
