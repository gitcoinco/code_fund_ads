# frozen_string_literal: true

Rails.application.routes.draw do
  resources :campaign_searches, only: [:create, :destroy]
  resources :user_searches, only: [:create, :destroy]

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
