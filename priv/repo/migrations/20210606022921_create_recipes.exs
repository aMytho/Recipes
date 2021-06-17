defmodule Recipebook.Repo.Migrations.CreateRecipes do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :name, :string
      add :time, :integer
      add :ingredients, :string
      add :instructions, :string

      timestamps()
    end

  end
end
