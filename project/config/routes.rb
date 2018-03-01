Rails.application.routes.draw do
  root 'static#home'

  get '/lists', to: 'users#show'
  
  post '/lists/destroylist', to: 'lists#destroylist', as: 'destroylist'

  get '/lists/modifyitem', to: 'lists#modifyitem', as: 'modifyitem'

  get '/lists/destroyitem', to: 'lists#destroyitem', as: 'destroyitem'

  get '/lists/list_items', to: 'lists#list_items'

  post '/lists/list_items', to: 'lists#list_items'

  get '/lists/get_list', to: 'lists#get_list'

  get '/lists/createlist', to: 'lists#create'

  get '/lists/create_item', to: 'lists#create_item', as: 'createitem'

  post '/lists/save_item', to: 'lists#save_item', as: 'saveitem'

  post '/lists/createlist', to: 'lists#save', as: 'save'

  get '/signup', to: 'users#new'

  post '/signup',  to: 'users#create'

  get 'static/home'

  get    '/login',   to: 'sessions#new' #returns login page

  post   '/login',   to: 'sessions#create' #processes login data
  
  get '/logout',  to: 'sessions#destroy'

  # get '/groups', to: "groups#foo"


  resources :users 

end
