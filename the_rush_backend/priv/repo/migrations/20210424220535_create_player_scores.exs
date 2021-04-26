defmodule TheRushBackend.Repo.Migrations.CreatePlayerScores do
  use Ecto.Migration

  def change do
    create table(:player_scores) do
      add :player, :string
      add :team, :string
      add :pos, :string
      add :att, :integer
      add :att_g, :float
      add :yds, :float
      add :avg, :float
      add :yds_g, :float
      add :td, :integer
      add :lng, :float
      add :lng_t, :string
      add :first, :integer
      add :first_percent, :float
      add :twenty_plus, :integer
      add :forty_plus, :integer
      add :fum, :integer

      timestamps()
    end

  end
end
