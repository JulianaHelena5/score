defmodule Score.Repo.Migrations.CreateUsers do
  use Ecto.Migration
  
  def up do
    create table(:users) do
      add(:points, :integer, null: false)

      timestamps()
    end
  end

  def down do
    drop table(:users)
  end
end
