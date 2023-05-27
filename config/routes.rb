Rails.application.routes.draw do
  root to: "dashboard#index"

  resources :registrations, only: [:new, :create]
end
