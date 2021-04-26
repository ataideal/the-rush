defmodule TheRushBackend.Scores do
  @moduledoc """
  The Scores context.
  """

  import Ecto.Query, warn: false
  alias TheRushBackend.Repo

  alias TheRushBackend.Scores.PlayerScore

  @doc """
  Returns the list of player_scores.

  ## Examples

      iex> list_player_scores()
      [%PlayerScore{}, ...]

  """
  def list_player_scores do
    Repo.all(PlayerScore)
  end

  @doc """
  Gets a single player_score.

  Raises `Ecto.NoResultsError` if the Player score does not exist.

  ## Examples

      iex> get_player_score!(123)
      %PlayerScore{}

      iex> get_player_score!(456)
      ** (Ecto.NoResultsError)

  """
  def get_player_score!(id), do: Repo.get!(PlayerScore, id)

  @doc """
  Creates a player_score.

  ## Examples

      iex> create_player_score(%{field: value})
      {:ok, %PlayerScore{}}

      iex> create_player_score(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_player_score(attrs \\ %{}) do
    %PlayerScore{}
    |> PlayerScore.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a player_score.

  ## Examples

      iex> update_player_score(player_score, %{field: new_value})
      {:ok, %PlayerScore{}}

      iex> update_player_score(player_score, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_player_score(%PlayerScore{} = player_score, attrs) do
    player_score
    |> PlayerScore.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a player_score.

  ## Examples

      iex> delete_player_score(player_score)
      {:ok, %PlayerScore{}}

      iex> delete_player_score(player_score)
      {:error, %Ecto.Changeset{}}

  """
  def delete_player_score(%PlayerScore{} = player_score) do
    Repo.delete(player_score)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking player_score changes.

  ## Examples

      iex> change_player_score(player_score)
      %Ecto.Changeset{data: %PlayerScore{}}

  """
  def change_player_score(%PlayerScore{} = player_score, attrs \\ %{}) do
    PlayerScore.changeset(player_score, attrs)
  end

  def create_player_score_from_external_data(data \\ %{}) do
    PlayerScore.normalize_external_data(data)
    |> create_player_score()
  end


  def count_player_score(_options \\ %{}) do
    query =
      from ps in PlayerScore, select: count(ps.id)

    query |> Repo.one()
  end
end
