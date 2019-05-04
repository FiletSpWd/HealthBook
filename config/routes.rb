Rails.application.routes.draw do
  root 'recipes#index'
  
  resources :recipes
  post '/recipes/publish', to: 'recipes#publish'

  get '/page/index', to: 'page#index'
  get '/page/publish_need', to: 'page#publish_need'
  get '/ingredients', to: 'ingredients#index'
end
