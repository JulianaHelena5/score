defmodule Score.Entities.UsersTest do
  use Score.DataCase

  import Score.Factory

  alias Score.Entities.Users
  alias Score.Entities.Schemas.User

  @valid_attrs %{points: 0}
  @update_attrs %{points: 42}
  @invalid_attrs %{points: nil}
  @invalid_points_amount_attrs %{points: 150}

  describe "Users Entity" do
    test "list_all/0 returns all users" do
      user = insert!(:user, @valid_attrs)

      assert Users.list_all() == [user]
    end

    test "create/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create(@valid_attrs)
      assert user.points == 0
    end

    test "create/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create(@invalid_attrs)
    end

    test "create/1 returns error with numbers not between 0..100" do
      assert {:error, %Ecto.Changeset{}} = Users.create(@invalid_points_amount_attrs)
    end

    test "get_by_points/1 returns a user with given points" do
      user = insert!(:user, @valid_attrs)

      assert user == Users.get_by_points(@valid_attrs.points)
      assert @valid_attrs.points == user.points
    end

    test "update/2 with valid data updates the user" do
      {:ok, user} = Users.create(@valid_attrs)

      assert {:ok, %User{} = user} = Users.update(user, @update_attrs)
      assert user.points == 42
    end

    test "update/2 with invalid data returns error changeset" do
      {:ok, user} = Users.create(@valid_attrs)

      assert {:error, %Ecto.Changeset{}} = Users.update(user, @invalid_attrs)
      assert user.points == @valid_attrs.points
    end
  end
end
