class Recipe < ApplicationRecord
  has_many :compositions, class_name: "Composition", dependent: :destroy
  has_many :ingredients, through: :compositions
  belongs_to :category
  has_many :steps, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorite_recipes, dependent: :destroy
  has_many :marks, dependent: :destroy

  mount_uploader :photo, ImageUploader

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

  def get_mark
    self.marks.sum(:rating)
  end

  # param = 'fat', 'sugar', 'protein', 'calories'
  def get_params(param)
    self.ingredients.sum(param)
  end
end
