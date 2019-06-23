class CompositionsController < ApplicationController
  before_action :set_composition, only: [:edit, :update]
  before_action :authenticate_user!

  def edit
  end

  def update
    respond_to do |format|
      if @composition.update_attributes(post_params)
        format.html { redirect_to get_recipe, notice: 'Состав рецепта был обновлен.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def get_recipe
    Recipe.find(@composition.recipe_id)
  end

  def post_params
    params.require(:composition).permit(:weight)
  end

  def set_composition
    @composition = Composition.find(params[:id])
  end
end