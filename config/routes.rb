Rails.application.routes.draw do
  root 'static#home'

  get '/lists', to: 'users#show'

  get '/login', to: 'static#login'

  # get '/groups', to: "groups#foo"

  get '/signup', to: 'users#new'

  get 'static/home'
end
