Rails.application.routes.draw do
  root 'static#home'

  get '/lists', to: 'users#show'

  get '/login', to: 'static#login'

  # get '/groups', to: "groups#foo"

  get '/signup', to: 'users#new'

  get 'static/home'

  get    '/login',   to: 'sessions#new' #returns login page

  post   '/login',   to: 'sessions#create' #processes login data
  
  delete '/logout',  to: 'sessions#destroy'

end
