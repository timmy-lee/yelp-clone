Rails.application.routes.draw do
  root to: 'ui#directory'
  get 'ui', to: 'ui#directory'
  get 'ui/:action', controller: 'ui'

  get 'sign_in', to: 'sessions#new', as: 'sign_in'
  get 'sign_out', to: 'sessions#destroy', as: 'sign_out'
  post 'authenticate', to: 'sessions#create'

  resources :businesses, only: [:index, :show, :new, :create] do
    resources :reviews, only: [:new, :create]
  end
  get 'reviews/recent', to: 'reviews#recent'

  resources :users, only: [:create, :show]
  get '/register', to: 'users#new', as: 'register'
end
