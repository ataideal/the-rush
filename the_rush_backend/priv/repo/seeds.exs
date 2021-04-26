# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TheRushBackend.Repo.insert!(%TheRushBackend.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias TheRushBackend.Scores

Path.absname("priv/repo/imports/rushing.json")
|> File.read!()
|> Jason.decode!()
|> Enum.each(
  fn player_score_data ->
    case Scores.create_player_score_from_external_data(player_score_data) do
      {:ok, _} -> IO.puts "OK"
      {:error, changeset} -> IO.inspect {:error, changeset}
    end
  end
)
