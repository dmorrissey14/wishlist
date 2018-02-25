Rails.application.routes.draw do
  root 'static#home'

  get '/lists', to: 'users#show'
  
  post '/lists/destroylist', to: 'lists#destroylist', as: 'destroylist'

  get '/lists/modifyitem', to: 'lists#modifyitem', as: 'modifyitem'

  get '/lists/destroyitem', to: 'lists#destroyitem', as: 'destroyitem'

  get '/lists/list_items', to: 'lists#list_items'

  post '/lists/list_items', to: 'lists#list_items'

  get '/lists/get_list', to: 'lists#get_list'

  get '/login', to: 'static#login'

  get '/lists/createlist', to: 'lists#create'

  # get '/groups', to: "groups#foo"

  post '/lists/createlist', to: 'lists#save', as: 'save'

  get '/signup', to: 'users#new'

  get 'static/home'
end
