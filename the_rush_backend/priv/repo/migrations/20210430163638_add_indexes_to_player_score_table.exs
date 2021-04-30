defmodule TheRushBackend.Repo.Migrations.AddIndexesToPlayerScoreTable do
  use Ecto.Migration
  @disable_ddl_transaction true
  @disable_migration_lock true

  def change do
    create index("player_scores",["(to_tsvector('english', player))"], using: :gin, concurrently: true)
    create index("player_scores", [:yds], concurrently: true)
    create index("player_scores", [:lng], concurrently: true)
    create index("player_scores", [:td], concurrently: true)
  end
end
