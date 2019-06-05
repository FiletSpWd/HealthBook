class MenusController < ApplicationController

  def index
    @menus = Menu.joins(:recipe, :user).where('menus.user_id = ?', current_user.id).order(date_meal: :desc)
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.new(menu_params)
    @menu.user_id = current_user.id
    recipe = Recipe.find @menu.recipe_id
    if @menu.save
      redirect_to recipe,  notice: 'Рецепт добавлен в меню! ' 
    end
  end

  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy
    respond_to do |format|
      format.html { redirect_to menus_url, notice: 'Рецепт был удален из вашего меню.' }
      format.json { head :no_content }
    end
  end

  private

  def menu_params
    params.require(:menu).permit(:date_meal, :weight, :recipe_id)
  end
end