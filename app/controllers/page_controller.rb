class PageController < ApplicationController

  def index
  end	
  
  def publish_need
  	@recipes = Recipe.no_published
  end
end