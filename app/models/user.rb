class User < ApplicationRecord
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
                 
  # validates_format_of :phone,
  # :with => /\(?[0-9]{2}\)?-[0-9]{3}-[0-9]{4}/,
  # :message => "- Phone numbers must be in xx-xxx-xxxx format."
end
