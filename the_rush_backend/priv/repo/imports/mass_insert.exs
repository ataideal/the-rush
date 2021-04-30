def mass_insert(n) do
  fixture = %{
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
  Enum.each(1..n, fn x ->
    IO.puts x
    TheRushBackend.Scores.create_player_score(fixture)
  end)

end

mass_insert(10_000)
