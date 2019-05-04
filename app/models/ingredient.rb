class Ingredient < ApplicationRecord
  
  def self.search_category(search)
  	self.where('category = ?', '%#{search}%')
  end
end
