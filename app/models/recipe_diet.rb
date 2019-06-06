class RecipeDiet < ApplicationRecord
  belongs_to :recipe
  belongs_to :diet
end
