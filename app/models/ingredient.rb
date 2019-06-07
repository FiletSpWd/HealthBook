class Ingredient < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_title, :against => [:title],
    using: {
      :tsearch => {:prefix => true}
    }
  has_many :compositions, class_name: "Composition", dependent: :destroy
  has_many :recipes, through: :recipes

  def self.search_category(search)
  	self.where('category = ?', '%#{search}%')
  end
end
