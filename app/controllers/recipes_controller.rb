class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :destroy, :update, :publish]

  def index
    @recipes = Recipe.published
  end

  def show
    @comment = Comment.new
    @comment.recipe_id = @recipe.id
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(post_params)
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
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
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
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
      format.html { redirect_to recipes_path, notice: 'Recipe was successfully destroy'}
      format.json { head :no_content }
    end
  end

  def publish
  	@recipe.published = true
  	@recipe.save
  	respond_to do |format|
      format.html { redirect_to @recipe, notice: 'Recipe was successfully published.' }
      format.json { render :show, status: :ok, location: @recipe }
    end
  end

  def what_to_cook
    @recipes = Recipe.includes(:compositions).all
                    .select {|i| i.compositions.map(&:ingredient_id)
                    .to_set.subset?(params[:ingredients].to_a
                    .map(&:to_i).to_set) }
  end

  private

  def post_params
    params.require(:recipe).permit(:title, :photo, :description, :all_products, :category_id)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
