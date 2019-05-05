class IngredientsController < ApplicationController
	
  def index
  	@ingredients = Ingredient.all
  end

  def kitchen 
    @ingredients = Ingredient.all
  end
end
