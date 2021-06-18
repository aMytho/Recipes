defmodule Recipebook.RecipeList.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recipes" do
    field :ingredients, :string
    field :instructions, :string
    field :name, :string
    field :time, :integer
    field :img_file_path, :string # Unused
    field :img_id, :integer, default: -1

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    IO.inspect attrs
    IO.inspect(recipe)
    recipe
    |> cast(attrs, [:name, :time, :ingredients, :instructions, :img_id])
    |> validate_required([:name, :time, :ingredients, :instructions, :img_id])
  end
end
