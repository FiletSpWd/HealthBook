class Diet < ApplicationRecord
  has_many :recipe_diets, dependent: :destroy
  has_many :recipes, through: :recipes
end
