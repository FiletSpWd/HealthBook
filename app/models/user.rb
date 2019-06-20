class User < ApplicationRecord
  rolify
  resourcify
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy
  has_many :favorite_recipes, dependent: :destroy
  has_many :marks, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :menus, dependent: :destroy

  validates :phone,:presence => true,
                 :numericality => true,
                 :length => { :minimum => 11, :maximum => 11 }
  
  after_create :assign_default_role

  def assign_default_role
    self.add_role(:newuser) if self.roles.blank?
  end

  def empty_fields?
    result = !activity.nil? && !growth.nil? && !weigth.nil?
  end
                 
  def get_calories
    calories = 10*self.weigth+6.25*self.growth-5*age
    if self.sex=='male'
      calories += 5
    else
      calories -= 161
    end    
    sprintf('%.2f', calories*self.activity.to_f)
  end

  def get_difference
    diff=get_calories.to_f - self.menus.get_calories_of_day(Date.today).to_f
    sprintf('%.2f', diff)
  end
  
  def get_percent
    percent=100-get_difference.to_f*100/get_calories.to_f
  end

  def age
    ((Time.zone.now - self.date_of_birth.to_time) / 1.year.seconds).floor
  end

  def get_days_menu
    self.menus.select(:date_meal).group(:date_meal).order(date_meal: :desc)
  end
end
