class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :destroy, :update, :publish]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:search]
      q = params[:search]
      order = params[:desc] ? 'DESC' : 'ASC'
      if !q.to_s.strip.empty?
        @search_results_recipes = sorting_by_mark(order).search_by_title(q)
      elsif params[:sorting_by_name]!='mark'
        @search_results_recipes = Recipe.published.order(params[:sorting_by_name].to_s+ ' ' + order.to_s)
      elsif params[:sorting_by_name]=='mark'
        @search_results_recipes = sorting_by_mark(order)
      end
      respond_to do |format|
        format.js { render partial: 'search-results'}
      end
    else
      @search_results_recipes = Recipe.published
    end
  end

  def show
    @comment = Comment.new
    @comment.recipe_id = @recipe.id
    @menu = Menu.new
    @menu.recipe_id = @recipe.id
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(post_params)
    @recipe.user = current_user
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Рецепт создан!' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
  	respond_to do |format|
      if @recipe.update_attributes(post_params)
        format.html { redirect_to @recipe, notice: 'Рецепт обновлен!' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe.destroy!
    respond_to do |format|
      format.html { redirect_to recipes_path, notice: 'Рецепт удален.'}
      format.json { head :no_content }
    end
  end

  def publish
  	@recipe.published = true
  	@recipe.save
  	respond_to do |format|
      format.html { redirect_to @recipe, notice: 'Рецепт опубликован.' }
      format.json { render :show, status: :ok, location: @recipe }
    end
  end

  def what_to_cook
    @recipes = Recipe.includes(:compositions).published
                    .select {|i| i.compositions.map(&:ingredient_id)
                    .to_set.subset?(params[:ingredients].to_a
                    .map(&:to_i).to_set) }
  end

  private

  def sorting_by_mark(order)
      Recipe.left_outer_joins(:marks).group('recipes.id').published.order('sum(marks.rating) ' + order.to_s)
  end


  def post_params
    params.require(:recipe).permit(:title, :photo, :description, :all_products, :category_id, :diet_ids)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
