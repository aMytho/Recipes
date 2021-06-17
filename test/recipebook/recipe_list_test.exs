defmodule Recipebook.RecipeListTest do
  use Recipebook.DataCase

  alias Recipebook.RecipeList

  describe "recipes" do
    alias Recipebook.RecipeList.Recipe

    @valid_attrs %{ingredients: "some ingredients", instructions: "some instructions", name: "some name", time: 42}
    @update_attrs %{ingredients: "some updated ingredients", instructions: "some updated instructions", name: "some updated name", time: 43}
    @invalid_attrs %{ingredients: nil, instructions: nil, name: nil, time: nil}

    def recipe_fixture(attrs \\ %{}) do
      {:ok, recipe} =
        attrs
        |> Enum.into(@valid_attrs)
        |> RecipeList.create_recipe()

      recipe
    end

    test "list_recipes/0 returns all recipes" do
      recipe = recipe_fixture()
      assert RecipeList.list_recipes() == [recipe]
    end

    test "get_recipe!/1 returns the recipe with given id" do
      recipe = recipe_fixture()
      assert RecipeList.get_recipe!(recipe.id) == recipe
    end

    test "create_recipe/1 with valid data creates a recipe" do
      assert {:ok, %Recipe{} = recipe} = RecipeList.create_recipe(@valid_attrs)
      assert recipe.ingredients == "some ingredients"
      assert recipe.instructions == "some instructions"
      assert recipe.name == "some name"
      assert recipe.time == 42
    end

    test "create_recipe/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RecipeList.create_recipe(@invalid_attrs)
    end

    test "update_recipe/2 with valid data updates the recipe" do
      recipe = recipe_fixture()
      assert {:ok, %Recipe{} = recipe} = RecipeList.update_recipe(recipe, @update_attrs)
      assert recipe.ingredients == "some updated ingredients"
      assert recipe.instructions == "some updated instructions"
      assert recipe.name == "some updated name"
      assert recipe.time == 43
    end

    test "update_recipe/2 with invalid data returns error changeset" do
      recipe = recipe_fixture()
      assert {:error, %Ecto.Changeset{}} = RecipeList.update_recipe(recipe, @invalid_attrs)
      assert recipe == RecipeList.get_recipe!(recipe.id)
    end

    test "delete_recipe/1 deletes the recipe" do
      recipe = recipe_fixture()
      assert {:ok, %Recipe{}} = RecipeList.delete_recipe(recipe)
      assert_raise Ecto.NoResultsError, fn -> RecipeList.get_recipe!(recipe.id) end
    end

    test "change_recipe/1 returns a recipe changeset" do
      recipe = recipe_fixture()
      assert %Ecto.Changeset{} = RecipeList.change_recipe(recipe)
    end
  end
end
