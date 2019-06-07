class IngredientsController < ApplicationController
	
  def index
    if params[:search]
      q = params[:search]
      if !q.to_s.strip.empty?
        @search_results_ingredients = Ingredient.search_by_title(q)
      else 
        @search_results_ingredients = Ingredient.all.order('title')
      end
      respond_to do |format|
        format.js { render partial: 'search-results'}
      end
    else
      @search_results_ingredients = Ingredient.all.order('title')
    end
  end

  def json_list
    @ingredients = Ingredient.all
    search = params[:term]
    render json: @ingredients.select('title as value, id as data').where('title LIKE ?', "%#{search}%"), status: :ok
  end
  
  def kitchen 
    @ingredients = Ingredient.all.order('title')
  end
end
