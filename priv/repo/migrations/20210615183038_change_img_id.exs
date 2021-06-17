defmodule Recipebook.Repo.Migrations.ChangeImgId do
  use Ecto.Migration

  def change do
    alter table(:recipes) do
      remove :img_id
      add :img_id, :integer
    end
  end
end
