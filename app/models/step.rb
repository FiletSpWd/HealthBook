class Step < ApplicationRecord
  belongs_to :recipe
  validates :title, :description, presence: true
end
