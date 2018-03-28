Rails.application.routes.draw do
  root 'static#home'

  get '/lists', to: 'users#show'

  get '/signup', to: 'users#new'

  post '/signup', to: 'users#create'

  get '/view_list', to: 'lists#view_list'

  get 'static/home'

  get  '/login',   to: 'sessions#new' #returns login pa 
  post '/login',   to: 'sessions#create' #processes login data

  get '/logout',  to: 'sessions#destroy'

  post 'list_items/new', to: 'list_items#new'

  # get '/groups', to: "groups#foo"

  resources :users
  resources :lists
  resources :list_items
end
