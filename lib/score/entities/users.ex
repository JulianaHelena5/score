defmodule Score.Entities.Users do
  @moduledoc """
  Represents the Users Entity.
  """
  import Ecto.Query

  alias Score.{Entities.Schemas.User, Repo}

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
  Gets a list of x (limit) Users greater than a integer value (max_number).
  ## Examples
      iex> get_users_with_points_greater_than(34, 2)
      [%User{}, %User{}]
  """
  def get_users_with_points_greater_than(max_number, _limit) when is_nil(max_number),
    do: {:error, :max_number_nil}

  def get_users_with_points_greater_than(_max_number, limit) when is_nil(limit),
    do: {:error, :limit_nil}

  def get_users_with_points_greater_than(max_number, limit)
      when not is_integer(limit) or not is_integer(max_number),
      do: {:error, :incorrect_format_params}

  def get_users_with_points_greater_than(max_number, limit)
      when is_integer(max_number) and is_integer(limit) do
    Repo.all(
      from(user in User,
        where: user.points > ^max_number,
        limit: ^limit
      )
    )
  end

  @doc """
  Updates all User's points with random numbers (0..100).

  ## Examples
      iex> update_all_points()
      {:ok, number_of_users_updated}

      iex> update_all_points()
      {:error, error}
  """
  def update_all_points() do
    update(User,
      set: [
        points: fragment("floor(random()*100)"),
        updated_at: fragment("NOW()")
      ]
    )
    |> Repo.update_all([])
    |> case do
      {number_of_users_updated, _} ->
        {:ok, number_of_users_updated}

      error ->
        {:error, error}
    end
  end
end
