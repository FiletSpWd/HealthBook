class IngredientsController < ApplicationController
	
  def index
    @ingredients = Ingredient.all
  end

  def json_list
    @ingredients = Ingredient.all
    search = params[:term]
    render json: @ingredients.select('title as value, id as data').where('title LIKE ?', "%#{search}%"), status: :ok
  end
  

  def kitchen 
    @ingredients = Ingredient.all
  end
end
