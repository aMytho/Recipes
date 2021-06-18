defmodule Recipebook.Repo.Migrations.IncreaseLength do
  use Ecto.Migration

  def change do
    alter table(:recipes) do
      modify :instructions, :text
      modify :ingredients, :text
    end
  end
end
