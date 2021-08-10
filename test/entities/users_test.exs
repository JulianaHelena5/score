defmodule Score.Entities.UsersTest do
  @moduledoc """
  Represents Users Entity Tests.
  """
  use Score.DataCase

  import Score.Factory

  alias Score.Entities.Schemas.User
  alias Score.Entities.Users

  @valid_attrs %{points: 0}
  @invalid_attrs %{points: nil}
  @invalid_points_amount_attrs %{points: 150}

  describe "Users Entity" do
    test "create/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create(@valid_attrs)
      assert user.points == 0
    end

    test "create/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create(@invalid_attrs)
    end

    test "create/1 returns error with numbers not between 0..100" do
      assert {
               :error,
               %Ecto.Changeset{}
             } = Users.create(@invalid_points_amount_attrs)
    end

    test "get_users_with_points_greater_than/2 returns user with points greater
    then given value" do
      user_with_43_points = insert!(:user, %{points: 43})
      value_44 = 44
      insert!(:user, %{points: 45})
      insert!(:user, %{points: 46})

      assert [
               %User{
                 points: 45
               },
               %User{
                 points: 46
               }
             ] = Users.get_users_with_points_greater_than(value_44, 2)

      refute Enum.member?(
               Users.get_users_with_points_greater_than(value_44, 2),
               user_with_43_points
             )
    end

    test "update_all_points/0 updates all Users points" do
      Users.create(@valid_attrs)
      Users.create(@valid_attrs)
      Users.create(@valid_attrs)

      assert {:ok, value} = Users.update_all_points()
      assert value == 3
    end
  end
end
