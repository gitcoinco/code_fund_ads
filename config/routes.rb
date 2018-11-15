# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "pages#index"

  devise_for :users, controllers: {
    sessions: "sessions",
    invitations: "invitations"
  }

  resource :dashboard, only: [:show]
  resource :contact, only: [:show, :create]
  resources :campaign_searches, only: [:create, :destroy]
  resources :property_searches, only: [:create, :destroy]
  resources :user_searches, only: [:create, :destroy]

  # polymorphic based on: app/models/concerns/imageable.rb
  scope "/imageables/:imageable_gid/" do
    resources :images, except: [:show]
  end

  resources :campaigns
  resources :creatives
  resources :impressions
  resources :properties
  resources :templates
  resources :themes
  resources :users
  resource :user_passwords, only: [:edit, :update], path: "/password"

  scope "/users/:user_id" do
    resources :campaigns, only: [:index], as: :user_campaigns
    resources :properties, only: [:index], as: :user_properties
    resources :creatives, only: [:index], as: :user_creatives
  end

  resource :newsletter_subscription, only: [:create]
  resources :advertisers, only: [:index, :create]
  resources :publishers, only: [:index, :create]

  # IMPORTANT: leave as last route so it doesn't override others
  resources :pages, only: [:show], path: "/"
end
