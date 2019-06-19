class FavoriteRecipesController < ApplicationController
  before_action :set_favorite_recipe, only: [:destroy]
  before_action :authenticate_user!

  def index
    @recipes = Recipe.joins(:favorite_recipes).where('favorite_recipes.user_id = ?', current_user.id)
  end

  def new
    @favorite_recipe = FavoriteRecipe.new
  end

  def create
    @favorite_recipe = FavoriteRecipe.new
    @favorite_recipe.user_id = current_user.id
    @favorite_recipe.recipe_id = params[:format]
    recipe = Recipe.find @favorite_recipe.recipe_id
    if @favorite_recipe.save
      redirect_to recipe,  notice: 'Рецепт был добавлен в избранные!'
    end
  end

  def destroy
    @favorite_recipe.destroy
    respond_to do |format|
      format.html { redirect_to favorite_recipes_url, notice: 'Рецепт был удален из библиотеки' }
      format.json { head :no_content }
    end
  end

  private

  def set_favorite_recipe
    @favorite_recipe = FavoriteRecipe.find_by(recipe_id: params[:id], user_id: current_user)
  end

  def favorite_recipe_params
    params.require(:favorite_recipe).permit(:recipe_id)
  end
end