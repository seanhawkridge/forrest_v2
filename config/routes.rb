Rails.application.routes.draw do
  resources :users
  resources :tournaments
  resources :matches
  resources :players
  root to: 'players#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  post 'tournaments/:id/build_tournament', to: 'tournaments#build_tournament'
end
