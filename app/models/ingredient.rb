class Ingredient < ApplicationRecord
  has_many :compositions, class_name: "Composition", dependent: :destroy
  has_many :recipes, through: :recipes

  def self.search_category(search)
  	self.where('category = ?', '%#{search}%')
  end
end
