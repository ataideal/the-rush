defmodule TheRushBackend.ScoresTest do
  use TheRushBackend.DataCase

  alias TheRushBackend.Scores

  describe "player_scores" do
    alias TheRushBackend.Scores.PlayerScore

    @valid_attrs %{att: 42, att_g: 120.5, avg: 120.5, first: 42, first_percent: 120.5, forty_plus: 42, fum: 42, lng: 120.5, player: "some player", pos: "some pos", td: 42, team: "some team", twenty_plus: 42, yds: 120.5, yds_g: 120.5}
    @update_attrs %{att: 43, att_g: 456.7, avg: 456.7, first: 43, first_percent: 456.7, forty_plus: 43, fum: 43, lng: 456.7, player: "some updated player", pos: "some updated pos", td: 43, team: "some updated team", twenty_plus: 43, yds: 456.7, yds_g: 456.7}
    @invalid_attrs %{att: nil, att_g: nil, avg: nil, first: nil, first_percent: nil, forty_plus: nil, fum: nil, lng: nil, player: nil, pos: nil, td: nil, team: nil, twenty_plus: nil, yds: nil, yds_g: nil}

    def player_score_fixture(attrs \\ %{}) do
      {:ok, player_score} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Scores.create_player_score()

      player_score
    end

    test "list_player_scores/0 returns all player_scores" do
      player_score = player_score_fixture()
      assert Scores.list_player_scores() == [player_score]
    end

    test "get_player_score!/1 returns the player_score with given id" do
      player_score = player_score_fixture()
      assert Scores.get_player_score!(player_score.id) == player_score
    end

    test "create_player_score/1 with valid data creates a player_score" do
      assert {:ok, %PlayerScore{} = player_score} = Scores.create_player_score(@valid_attrs)
      assert player_score.att == 42
      assert player_score.att_g == 120.5
      assert player_score.avg == 120.5
      assert player_score.first == 42
      assert player_score.first_percent == 120.5
      assert player_score.forty_plus == 42
      assert player_score.fum == 42
      assert player_score.lng == "some lng"
      assert player_score.player == "some player"
      assert player_score.pos == "some pos"
      assert player_score.td == 42
      assert player_score.team == "some team"
      assert player_score.twenty_plus == 42
      assert player_score.yds == 120.5
      assert player_score.yds_g == 120.5
    end

    test "create_player_score/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scores.create_player_score(@invalid_attrs)
    end

    test "update_player_score/2 with valid data updates the player_score" do
      player_score = player_score_fixture()
      assert {:ok, %PlayerScore{} = player_score} = Scores.update_player_score(player_score, @update_attrs)
      assert player_score.att == 43
      assert player_score.att_g == 456.7
      assert player_score.avg == 456.7
      assert player_score.first == 43
      assert player_score.first_percent == 456.7
      assert player_score.forty_plus == 43
      assert player_score.fum == 43
      assert player_score.lng == "some updated lng"
      assert player_score.player == "some updated player"
      assert player_score.pos == "some updated pos"
      assert player_score.td == 43
      assert player_score.team == "some updated team"
      assert player_score.twenty_plus == 43
      assert player_score.yds == 456.7
      assert player_score.yds_g == 456.7
    end

    test "update_player_score/2 with invalid data returns error changeset" do
      player_score = player_score_fixture()
      assert {:error, %Ecto.Changeset{}} = Scores.update_player_score(player_score, @invalid_attrs)
      assert player_score == Scores.get_player_score!(player_score.id)
    end

    test "delete_player_score/1 deletes the player_score" do
      player_score = player_score_fixture()
      assert {:ok, %PlayerScore{}} = Scores.delete_player_score(player_score)
      assert_raise Ecto.NoResultsError, fn -> Scores.get_player_score!(player_score.id) end
    end

    test "change_player_score/1 returns a player_score changeset" do
      player_score = player_score_fixture()
      assert %Ecto.Changeset{} = Scores.change_player_score(player_score)
    end
  end
end
