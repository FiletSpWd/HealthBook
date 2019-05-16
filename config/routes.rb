Rails.application.routes.draw do
  root 'recipes#index'
 
  resources :recipes
  post '/recipes/publish', to: 'recipes#publish'

  get '/page/index', to: 'page#index'
  get '/page/publish_need', to: 'page#publish_need'

  get '/ingredients', to: 'ingredients#index'
  get '/ingredients/kitchen', to: 'ingredients#kitchen'
  get '/ingredients/json_list', to: 'ingredients#json_list'

  resources :compositions
  resources :categories
  get 'recipe/what_to_cook', to: 'recipes#what_to_cook', as: :what_to_cook
end
