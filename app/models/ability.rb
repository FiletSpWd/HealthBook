# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil?
      user = User.new
    end
    if user.has_role? :admin, user
      can :manage, :all
    elsif user.has_role? :editor, user
      can :manage, Category
      can :manage, Recipe
      can :manage, Advice
    elsif user.has_role? :newuser, user
      can :add, Recipe
      can [:update, :destroy], Recipe, :user_id => user.id
      can [:update], User, :id => user.id
      can [:manage], Comment, :user_id => user.id
    else 
      can :read, :all
    end
  end
end
