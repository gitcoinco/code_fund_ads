# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

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

  scope "/users/:user_id" do
    resources :campaigns, only: [:index], as: :user_campaigns
    resources :properties, only: [:index], as: :user_properties
    resources :creatives, only: [:index], as: :user_creatives
  end

  get "/publishers", to: "home#publishers", as: :home_publishers
  post "/publishers", to: "home#create_publisher"
  get "/advertisers", to: "home#advertisers", as: :home_advertisers
  post "/advertisers", to: "home#create_advertiser"
  get "/help", to: "home#help", as: :home_help
  get "/team", to: "home#team", as: :home_team

  root "home#index"
end
