defmodule Score.Entities.Schemas.UserTest do
  use Score.DataCase

  alias Score.Entities.Schemas.User

  @valid_attrs %{points: 15}
  @invalid_attrs %{points: "invalid"}
  @invalid_points_amount_attrs %{points: 150}
  @bottom_limit_range_attrs %{points: 0}
  @top_limit_range_attrs %{points: 100}

  describe "User Schema" do
    test "should create an User with valid points" do
      assert %Ecto.Changeset{
               changes: changes,
               valid?: true,
               errors: []
             } = User.changeset(%User{}, @valid_attrs)

      assert @valid_attrs == changes
    end

    test "should create an User with the bottom limit of the points range" do
      assert %Ecto.Changeset{
               changes: changes,
               valid?: true,
               errors: []
             } = User.changeset(%User{}, @bottom_limit_range_attrs)

      assert 0 == changes.points
    end

    test "should create an User with the top limit of the points range" do
      assert %Ecto.Changeset{
               changes: changes,
               valid?: true,
               errors: []
             } = User.changeset(%User{}, @top_limit_range_attrs)

      assert 100 == changes.points
    end

    test "shouldn't create an User with invalid points" do
      errors = errors_on(User.changeset(%User{}, %{points: @invalid_attrs}))

      assert %{points: ["is invalid"]} == errors
    end

    test "shouldn't create an User with empty points" do
      errors = errors_on(User.changeset(%User{}, %{}))

      assert %{points: ["can't be blank"]} == errors
    end

    test "should validate that points is a number between 0..100" do
      errors = User.changeset(%User{}, @invalid_points_amount_attrs)

      assert {"Points must be a number between 0..100", _} = errors.errors[:points]
    end
  end
end
