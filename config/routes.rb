Rails.application.routes.draw do
  get 'registrations/new'
  root 'registrations#new'
  resources :credentials, only: [:create]
end
