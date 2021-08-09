defmodule Score.Services.UserServiceTest do
  @moduledoc """
  UserService contains User business logic Tests.
  """
  use Score.DataCase

  import ExUnit.CaptureLog
  import Score.Factory

  alias Score.Services.UserService

  describe "UserService" do
    test "get_users_with_points_greater_than/2 returns users with points greater
    then given value" do
      user_with_42_points = insert!(:user, %{points: 42})
      value_43 = 43
      user_with_45_points = insert!(:user, %{points: 45})
      user_with_46_points = insert!(:user, %{points: 46})

      assert {:ok, users_list = [user_with_45_points, user_with_46_points]} ==
               UserService.get_users(%{
                 max_number: value_43,
                 limit: 2
               })

      refute Enum.member?(users_list, user_with_42_points)
    end

    test "get_users_with_points_greater_than/2 returns [] for a given value" do
      insert!(:user, %{points: 42})
      value_43 = 43

      assert {:ok, []} =
               UserService.get_users(%{
                 max_number: value_43,
                 limit: 2
               })
    end

    test "get_users_with_points_greater_than/2 returns :incorrect_format_params" do
      insert!(:user, %{points: 42})
      value_43 = "43"

      assert log =
               capture_log(fn ->
                 assert {:error, :incorrect_format_params} =
                          UserService.get_users(%{max_number: value_43, limit: "4"})
               end)

      assert log =~ "Error trying to get users: :incorrect_format_params"
    end

    test "update_every_users_point/0 updates all Users points" do
      insert!(:user, %{points: 15})
      insert!(:user, %{points: 25})
      insert!(:user, %{points: 35})

      assert log =
               capture_log(fn ->
                 assert {:ok, message} = UserService.update_every_users_point()
                 assert message == 3
               end)

      assert log =~ "Bulk update in local database finished."
    end
  end
end
