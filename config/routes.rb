Rails.application.routes.draw do
  resources :tickets
  resources :reviews
  resources :events
  resources :rooms
  resources :admins
  resources :users
  resources :events do
    resources :tickets, only: [:new, :create, :index, :show] # Adjust based on needed actions
    resources :reviews, only: [:new, :create]
  end

  resources :users do
    get 'booking_history', on: :member
  end
  get '/my_booking_history', to: 'tickets#booking_history', as: :booking_history
  get 'search_attendees', to: 'events#search_attendees'
  #get 'home/index'
  root 'home#index'
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: "users#new", as: 'signup'
  get 'login', to: "sessions#new", as: 'login'
  get 'logout', to: "sessions#destroy", as: 'logout'
  get 'roomsearch', to: "rooms#search", as: 'roomsearch'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
