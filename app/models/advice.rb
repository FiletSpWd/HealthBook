class Advice < ApplicationRecord

  def self.random_advice
    self.order('RANDOM()').limit(4)
  end
end
