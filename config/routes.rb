Rails.application.routes.draw do
  root 'static#home'

  get '/lists', to: 'users#show'

  get '/login', to: 'static#login'

  get '/lists/createlist', to: 'lists#create'

  # get '/groups', to: "groups#foo"

  post '/lists/createlist', to: 'lists#save', as: 'save'

  get '/signup', to: 'users#new'

  get 'static/home'
end
