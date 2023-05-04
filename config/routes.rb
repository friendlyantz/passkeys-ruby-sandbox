Rails.application.routes.draw do
  resource :registrations, only: [:new, :create] do
  #   # post :callback
  end

  # get 'home/index'
  root to: "home#index"

  resource :session, only: [:new, :create, :destroy] do
    # post :callback
  end

  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
