defmodule Recipebook.Repo.Migrations.AddID do
  use Ecto.Migration

  def change do
    alter table(:recipes) do
      add :img_id, :integer
    end
  end
end
