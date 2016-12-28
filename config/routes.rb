Rails.application.routes.draw do


  get  'home/index'
  get  'signup' => 'users#new'
  post 'signup' => 'users#create'
  resources :users
  root 'home#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
