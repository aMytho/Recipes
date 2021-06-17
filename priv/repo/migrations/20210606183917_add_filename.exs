defmodule Recipebook.Repo.Migrations.AddFilename do
  use Ecto.Migration

  def change do
    alter table(:recipes) do
      add :img_file_path, :string
    end
  end
end
