defmodule Score.Entities.Users do
  @moduledoc """
  Represents the Users Entity.
  """
  import Ecto.Query, warn: false

  alias Score.Entities.Schemas.User
  alias Score.Repo

  @doc """
  Creates a user.

  ## Examples
      iex> create(%{field: value})
      {:ok, %User{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns the list of users.

  ## Examples
      iex> list_all()
      [%User{}, ...]
  """
  def list_all do
    Repo.all(User)
  end

  @doc """
  Gets a single user according a point value.

  Raises `Ecto.NoResultsError` if none of the Users points match.

  ## Examples
      iex> get_by_points(42)
      %User{}

      no_match_number = 29
      iex> get_by_points(no_match_number)
      ** (Ecto.NoResultsError)
  """
  def get_by_points(points) do
    Repo.one(
      from(user in User,
        where: user.points == ^points
      )
    )
  end

  @doc """
  Updates a user.

  ## Examples
      iex> update(user, %{field: new_value})
      {:ok, %User{}}

      iex> update(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def update(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end
end
