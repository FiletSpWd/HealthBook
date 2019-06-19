class MenusController < ApplicationController
  before_action :authenticate_user!
  
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
    if current_user.get_difference.to_f >= @menu.get_calories.to_f
      if @menu.save
        redirect_to recipe,  notice: 'Рецепт добавлен в меню! ' 
      end
    else 
      redirect_to recipe,  alert: 'Рецепт не добавлен в меню! Слишком много калорий! Задумайтесь о том, чтобы изменить меню или пейте больше воды. Вода утоляет ложное чувство голод.' 
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