Rails.application.routes.draw do
  resources :themes
  resources :templates
  resources :properties
  resources :invitations
  resources :impressions
  resources :distributions
  resources :creatives
  resources :campaigns
  resources :assets
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
