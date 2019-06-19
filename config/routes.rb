Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/a', as: 'rails_admin'
  devise_for :users
  root 'page#index'
 
  resources :recipes do
    resources :comments
    resources :steps
  end
  post '/recipes/publish', to: 'recipes#publish'

  post '/marks/dislike', to: 'marks#dislike'
  post '/marks/like', to: 'marks#like'

  get '/page/index', to: 'page#index'
  get '/page/publish_need', to: 'page#publish_need'

  get '/ingredients', to: 'ingredients#index'
  get '/ingredients/kitchen', to: 'ingredients#kitchen'
  get '/ingredients/json_list', to: 'ingredients#json_list'

  resources :users, :only => [:show]

  resources :compositions
  resources :categories
  resources :diets
  resources :favorite_recipes
  resources :advices
  resources :menus
  get 'recipe/what_to_cook', to: 'recipes#what_to_cook', as: :what_to_cook
end
