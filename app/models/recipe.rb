class Recipe < ApplicationRecord
  has_many :compositions, class_name: "Composition", dependent: :destroy
  has_many :ingredients, through: :compositions

  def self.published
	self.where('published = true')
  end

  def self.no_published
	self.where('published = false')
  end
end
