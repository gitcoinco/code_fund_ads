require "sidekiq/web"
Sidekiq::Web.set :session_secret, Rails.application.credentials[:secret_key_base]

Rails.application.routes.draw do
  root to: "pages#index"

  authenticate :user, lambda { |user| AuthorizedUser.new(user).can_admin_system? } do
    mount Sidekiq::Web => "/sidekiq"
  end

  devise_for :users, controllers: {
    sessions: "sessions",
    invitations: "invitations",
  }

  resource :dashboard, only: [:show]
  resource :contact, only: [:show, :create]
  resources :campaign_searches, only: [:create, :destroy]
  resources :property_searches, only: [:create, :destroy]
  resources :user_searches, only: [:create, :destroy]

  # polymorphic based on: app/models/concerns/imageable.rb
  scope "/imageables/:imageable_gid/" do
    resources :image_searches, only: [:create, :destroy]
    resources :images, except: [:show]
  end

  resources :versions, only: [:show, :update]
  resources :comments, only: [:create, :destroy]

  resources :campaigns do
    resource :campaign_targeting, only: [:show], path: "/targeting"
    resource :campaign_budget, only: [:show], path: "/budget"
    resources :campaign_properties, only: [:index], path: "/properties"
  end
  scope "/campaigns/:campaign_id" do
    resources :versions, only: [:index], as: :campaign_versions
    resources :comments, only: [:index], as: :campaign_comments
  end

  resources :creatives
  resources :impressions

  resources :properties do
    resources :property_screenshots, only: [:update]
  end
  scope "/properties/:property_id" do
    resources :versions, only: [:index], as: :property_versions
    resources :comments, only: [:index], as: :property_comments
  end

  resources :templates
  resources :themes
  resources :users
  resource :user_passwords, only: [:edit, :update], path: "/password"

  scope "/users/:user_id" do
    resources :campaigns, only: [:index], as: :user_campaigns
    resources :properties, only: [:index], as: :user_properties
    resources :creatives, only: [:index], as: :user_creatives
    resources :versions, only: [:index], as: :user_versions
    resources :comments, only: [:index], as: :user_comments
  end

  resource :newsletter_subscription, only: [:create]
  resources :advertisers, only: [:index, :create]
  resources :publishers, only: [:index, :create]

  # IMPORTANT: leave as last route so it doesn't override others
  resources :pages, only: [:show], path: "/"
end
