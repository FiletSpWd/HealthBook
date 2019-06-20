class Category < ApplicationRecord
  has_many :recipes, dependent: :destroy
  validates :title, presence: true

  mount_uploader :cover, CoverCategoryUploader
end
