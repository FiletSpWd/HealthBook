class StepsController < ApplicationController
  before_action :set_step, only: [ :edit, :destroy, :update]
  before_action :authenticate_user!

  def new
    @step = set_recipe.steps.new
  end

  def create 
    @step = set_recipe.steps.new(step_params)
    respond_to do |format|
      if @step.save
        format.html { redirect_to(@step.recipe, :notice => 'Шаг создан!') }
        format.xml  { render :xml => @step, :status => :created, :location => @step.recipe }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @step.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @step.update_attributes(step_params)
        format.html { redirect_to(@step.recipe, :notice => 'Шаг изменен.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @step.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @step.destroy
    respond_to do |format|
      format.html { redirect_to(set_recipe) }
      format.xml  { head :ok }
    end
  end

  private

  def step_params
    params[:step].permit(:title, :description, :recipe_id, :position)
  end

  def set_recipe
    recipe = Recipe.find(params[:recipe_id])
  end

  def set_step
    recipe = Recipe.find(params[:recipe_id])
    @step = recipe.steps.find(params[:id])
  end
end