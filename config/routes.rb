Rails.application.routes.draw do


  resources :tests
  resources :solutions
  resources :problems
  resources :competitions
  get 'sessions/new'

  get  'home/index'
  
  # Signup Routing
  get  'signup' => 'users#new'
  post 'signup' => 'users#create'

  # Login Routing
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  get '/leaderboard' => 'users#index'

  resources :users
  root 'home#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
