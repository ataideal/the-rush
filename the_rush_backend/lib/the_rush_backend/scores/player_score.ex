defmodule TheRushBackend.Scores.PlayerScore do
  use Ecto.Schema
  import Ecto.Changeset

  schema "player_scores" do
    field :att, :integer
    field :att_g, :float
    field :avg, :float
    field :first, :integer
    field :first_percent, :float
    field :forty_plus, :integer
    field :fum, :integer
    field :lng, :float
    field :lng_t, :string
    field :player, :string
    field :pos, :string
    field :td, :integer
    field :team, :string
    field :twenty_plus, :integer
    field :yds, :float
    field :yds_g, :float

    timestamps()
  end

  @doc false
  def changeset(player_score, attrs) do

    player_score
    |> cast(attrs, [:player, :team, :pos, :att, :att_g, :yds, :avg, :yds_g, :td, :lng, :lng_t, :first, :first_percent, :twenty_plus, :forty_plus, :fum])
    |> validate_required([:player, :team, :pos, :att, :att_g, :yds, :avg, :yds_g, :td, :lng, :first, :first_percent, :twenty_plus, :forty_plus, :fum])
  end

  def normalize_external_data(attrs) do
    %{
      "player" => Map.get(attrs, "Player"),
      "team" => Map.get(attrs, "Team"),
      "pos" => Map.get(attrs, "Pos"),
      "att" => Map.get(attrs, "Att"),
      "att_g" => Map.get(attrs, "Att/G"),
      "yds" => Map.get(attrs, "Yds") |> normalize_yds(),
      "avg" => Map.get(attrs, "Avg"),
      "yds_g" => Map.get(attrs, "Yds/G"),
      "td" => Map.get(attrs, "TD"),
      "lng" => Map.get(attrs, "Lng") |> normalize_lng() |> elem(0),
      "lng_t" => Map.get(attrs, "Lng") |> normalize_lng() |> elem(1),
      "first" => Map.get(attrs, "1st"),
      "first_percent" => Map.get(attrs, "1st%"),
      "twenty_plus" => Map.get(attrs, "20+"),
      "forty_plus" => Map.get(attrs, "40+"),
      "fum" => Map.get(attrs, "FUM")
    }
  end

  def normalize_lng(lng) when is_bitstring(lng), do: Float.parse(lng)
  def normalize_lng(lng) when is_float(lng) or is_integer(lng), do: {lng, ""}

  def normalize_yds(yds) when is_bitstring(yds) do
     yds |> String.replace(",","") |> Float.parse() |> elem(0)
  end
  def normalize_yds(yds), do: yds


end
