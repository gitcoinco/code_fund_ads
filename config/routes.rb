Rails.application.routes.draw do
  resources :assets
  resources :campaigns
  resources :creatives
  resources :distributions
  resources :impressions
  resources :invitations
  resources :properties
  resources :templates
  resources :themes
  resources :users
  root "users#index"
end
