defmodule RecipebookWeb.RecipeController do
  use RecipebookWeb, :controller

  alias Recipebook.RecipeList
  alias Recipebook.RecipeList.Recipe
  alias Recipebook.Documents

  def table(conn, _params) do
    recipes = RecipeList.list_recipes()
    render(conn, "table.html", recipes: recipes)
  end

  def index(conn, _params) do
    recipes = RecipeList.list_recipes()
    render(conn, "index.html", recipes: recipes)
  end

  def new(conn, _params) do
    changeset = RecipeList.change_recipe(%Recipe{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"recipe" => recipe_params}) do
    recipe_params = add_image_if_exists(recipe_params)
    IO.puts "aaaaaaa"
    IO.inspect recipe_params
    case RecipeList.create_recipe(recipe_params) do
      {:ok, recipe} ->
        conn
        |> put_flash(:info, "Recipe created successfully.")
        |> redirect(to: Routes.recipe_path(conn, :show, recipe))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    recipe = RecipeList.get_recipe!(id)
    if Map.get(recipe, :img_file_path) === nil do
      recipe = Map.put(recipe, :img_file_path, "No image exists")
      render(conn, "show.html", recipe: recipe)
    else
      render(conn, "show.html", recipe: recipe)
    end
  end

  def edit(conn, %{"id" => id}) do
    recipe = RecipeList.get_recipe!(id)
    changeset = RecipeList.change_recipe(recipe)
    render(conn, "edit.html", recipe: recipe, changeset: changeset)
  end

  def update(conn, %{"id" => id, "recipe" => recipe_params}) do
    recipe = RecipeList.get_recipe!(id)

    case RecipeList.update_recipe(recipe, recipe_params) do
      {:ok, recipe} ->
        conn
        |> put_flash(:info, "Recipe updated successfully.")
        |> redirect(to: Routes.recipe_path(conn, :show, recipe))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", recipe: recipe, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    recipe = RecipeList.get_recipe!(id)
    {:ok, _recipe} = RecipeList.delete_recipe(recipe)
    conn
    |> put_flash(:info, "Recipe deleted successfully.")
    |> redirect(to: Routes.recipe_path(conn, :index))
  end

  defp add_image_if_exists(data) do
    IO.puts "here"
    if data["img_id"] do
      case Documents.create_upload_from_plug_upload(data["img_id"]) do
        {:ok, upload}->
          IO.puts "Everything is good"
          Map.put(data, "img_id", upload.id)
        {:error, reason}->
          IO.puts "Error with image"
          reason
      end
    else
      Map.put(data, :img_id, nil)
    end
  end
end
