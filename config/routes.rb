Rails.application.routes.draw do
  root 'registrations#new'
  resources :credentials, only: [:create]
  resources :registrations, only: [:new, :create]
end
