class Recipe < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_title, :against => [:title],
    using: {
      :tsearch => {:prefix => true}
    }
    
  has_many :compositions, class_name: "Composition", dependent: :destroy
  has_many :ingredients, through: :compositions
  belongs_to :category
  belongs_to :user
  has_many :steps, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorite_recipes, dependent: :destroy
  has_many :marks, dependent: :destroy
  has_many :menus, dependent: :destroy
  has_many :recipe_diets, dependent: :destroy
  has_many :diets, through: :recipe_diets

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

  def self.more_popular
    self.joins(:marks).group('recipes.id').published.order('sum(marks.rating) desc')
  end

  def self.random_recipes
    self.order('RANDOM()').limit(2)
  end

  # param = 'fat', 'sugar', 'protein', 'calories'
  def get_params(param)
    sprintf('%.2f', self.ingredients.sum(param) / 100)
  end
end
