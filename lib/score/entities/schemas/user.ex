defmodule Score.Entities.Schemas.User do
  @moduledoc """
  Representes the User Schema.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:points, :integer)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:points])
    |> validate_required([:points])
    |> validate_number(:points,
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100,
      message: "Points must be a number between 0..100"
    )
  end
end
