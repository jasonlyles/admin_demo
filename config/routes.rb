Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :apartments
  resources :guests
  resources :bookings
  resources :buildings

  root to: 'apartments#index'
end
