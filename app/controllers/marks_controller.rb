class MarksController < ApplicationController
  before_action :authenticate_user!

  def like
    @mark = set_recipe.marks.new(user_id: current_user.id, rating: 1)
    respond_to do |format|
      if @mark.save
        format.html { redirect_to(@mark.recipe, :notice => 'Рецепт оценен на +1!') }
        format.xml  { render :xml => @mark, :status => :created, :location => @mark.recipe }
      else
        format.html { redirect_to(set_recipe, :alert => 'Рецепт уже был оценен!') }
        format.xml  { render :xml => @mark.errors, :status => :unprocessable_entity }
      end
    end
  end

  def dislike
    @mark = set_recipe.marks.new(user_id: current_user.id, rating: -1)
    respond_to do |format|
      if @mark.save
        format.html { redirect_to(@mark.recipe, :notice => 'Рецепт оценен на -1.') }
        format.xml  { render :xml => @mark, :status => :created, :location => @mark.recipe }
      else
        format.html { redirect_to(set_recipe, :alert => 'Рецепт уже был оценен!') }
        format.xml  { render :xml => @mark.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def set_recipe
    recipe = Recipe.find(params[:recipe_id])
  end
end