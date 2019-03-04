Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root to: 'pages#home'
  get 'video', to: 'pages#video'

  get '/trips/search', to: 'trips#search'

  get '/users/geocoded-address', to:  "users#geocoded_address",  defaults: { format: :json }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :trips do
    resources :bookings, only: [:create, :update]
  end

  resources :bookings, only: [:index] do
    resources :reviews

  end

  namespace :my do
    resources :trips
    resources :bookings do
      member do
        patch :approve
      end
    end
  end
end
