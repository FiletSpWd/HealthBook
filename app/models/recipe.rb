class Recipe < ApplicationRecord

  def self.published
	self.where('published = true')
  end

  def self.no_published
	self.where('published = false')
  end
end
