defmodule Score.Factory do
  @moduledoc """
  Helper API to create and save entities in the database.
  """
  alias Score.Repo

  alias Score.Entities.Schemas.{
    User
  }

  def build(factory_name, attr) do
    factory_name
    |> build()
    |> struct(attr)
  end

  def build(:user) do
    %User{
      points: 42
    }
  end

  def insert!(factory_name, attr \\ []) do
    build(factory_name, attr)
    |> Repo.insert!()
  end
end
