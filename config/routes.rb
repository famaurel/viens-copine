Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root to: 'pages#home'

  get '/trips/search', to: 'trips#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :trips do
    resources :bookings, only: [:create, :update]
  end

  resources :bookings, only: [:index] do
    resources :reviews
  end


end
