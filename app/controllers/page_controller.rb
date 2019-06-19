class PageController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  
  def index
  end	
  
  def publish_need
  	@recipes = Recipe.no_published
  end
end