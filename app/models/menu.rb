class Menu < ApplicationRecord
  belongs_to :recipe
  belongs_to :user

  def get_calories
    calories = self.weight * self.recipe.get_params('calories') / 100
  end

  def self.get_calories_of_day(day)
    return sum_calories self.where('date_meal= ?', day)
  end

  def self.get_menu_of_day(day)
    self.where('date_meal= ?', day)
  end

  def self.get_dates
    self.select(:date_meal).group(:date_meal).order(date_meal: :desc)
  end

  def self.get_deg_of_circle
    procent = self.get_calories_of_day(Date.today)*100/3300
    deg = 360-360*procent/100
  end
  
  private

  def self.sum_calories(array_of_menu)
    calories = 0
    array_of_menu.each do |menu|
      calories += menu.get_calories
    end
    return calories
  end
end
