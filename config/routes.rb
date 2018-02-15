Rails.application.routes.draw do
  get 'static/home'

  get 'users/new'

  get 'users/show'

  get 'users/create'

  root 'static#home'

end
