class Recipe < ApplicationRecord
  has_many :compositions, class_name: "Composition", dependent: :destroy
  has_many :ingredients, through: :compositions

  def self.published
	  self.where('published = true')
  end

  def self.no_published
	  self.where('published = false')
  end

  def all_products
    self.ingredients.map(&:title).join(', ')
  end

  def all_products=(names)
    self.ingredients = names.split(',').map do |name|
      Ingredient.where(title: name.strip).first
    end
  end

  def printer
    puts 'Hello, Im work'
  end

  # param = 'fat', 'sugar', 'protein', 'calories'
  def get_params(param)
    self.ingredients.sum(param)
  end
end
