defmodule Score.Services.UserService do
  @moduledoc """
  UserService contains User business logic.
  """
  require Logger

  alias Score.Entities.Users

  def get_users(
        %{
          max_number: max_number,
          limit: limit
        } = _params
      ) do
    case Users.get_users_with_points_greater_than(max_number, limit) do
      [] ->
        Logger.info("Users not found for given (max_number = #{max_number})")
        :user_not_found

      {:error, error} ->
        Logger.error("Error trying to get users: #{inspect(error)}")

        {:error, error}

      users ->
        {:ok, users}
    end
  end

  def update_every_users_point() do
    case Users.update_all_points() do
      {:error, error} ->
        Logger.error("Error trying to update all Users points")
        error

      {:ok, number_of_users_updated} ->
        Logger.info("Bulk update in local database finished.
        Updated #{number_of_users_updated} User points")
        {:ok, number_of_users_updated}
    end
  end
end
