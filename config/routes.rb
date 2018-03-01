Rails.application.routes.draw do
  root 'static#home'

  get '/lists', to: 'users#show'

  # get '/groups', to: "groups#foo"

  get 'users/show'

  get '/signup', to: 'users#new'

  post '/signup',  to: 'users#create'

  get 'static/home'

  get    '/login',   to: 'sessions#new' #returns login page

  post   '/login',   to: 'sessions#create' #processes login data
  
  get '/logout',  to: 'sessions#destroy'

  resources :users 

end
