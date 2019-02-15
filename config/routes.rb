require "sidekiq/web"
Sidekiq::Web.set :session_secret, Rails.application.credentials[:secret_key_base]

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  authenticate :user, lambda { |user| AuthorizedUser.new(user || User.new).can_admin_system? } do
    mount Sidekiq::Web => "/sidekiq"
  end

  devise_for :users, controllers: {
    sessions: "sessions",
    invitations: "invitations",
  }

  resources :jobs, only: [:index]
  resources :job_posting_prospects, except: [:index, :destroy], path: "/jobs/listings"
  scope "/jobs/listings/:job_posting_id" do
    resource :job_posting_user, only: [:new, :create], path: "/user"
    resource :job_posting_purchase, only: [:new, :create, :show, :edit, :update], path: "/purchase"
  end
  resources :job_postings, except: [:new, :create], path: "/jobs/directory"

  root to: "pages#index"

  resource :pricing, only: [:show]
  resource :administrator_dashboards, only: [:show], path: "/dashboards/administrator"
  resource :advertiser_dashboards, only: [:show], path: "/dashboards/advertiser"
  resource :publisher_dashboards, only: [:show], path: "/dashboards/publisher"
  resources :campaign_searches, only: [:create, :update, :destroy]
  resources :creative_searches, only: [:create, :update, :destroy]
  resources :job_posting_searches, only: [:create, :update, :destroy], path: "/jobs/searches"
  resources :organization_searches, only: [:create, :update, :destroy]
  resources :property_searches, only: [:create, :update, :destroy]
  resources :user_searches, only: [:create, :update, :destroy]
  resource :creative_options, only: [:show]

  resources :organizations
  scope "/organization/:organization_id/" do
    resources :organization_transactions, path: "/transactions"
    resources :users, path: "/members", as: :organization_users
    resources :comments, only: [:index], as: :organization_comments
    resources :events, only: [:index], as: :organization_events
    resources :versions, only: [:index], as: :organization_versions, path: "/revisions"
  end

  resources :email_templates

  scope "/jobs", manage_scope: true do
    resources :job_postings, only: [:index, :edit, :update, :destroy], path: "/manage", as: :manage_job_postings
  end

  # polymorphic based on: app/models/concerns/imageable.rb
  scope "/imageables/:imageable_gid/" do
    resources :image_searches, only: [:create, :update, :destroy]
    resources :images, except: [:show]
  end

  resources :versions, only: [:show, :update]
  resources :comments, only: [:create, :destroy]

  resources :applicants
  scope "/applicants/:applicant_id" do
    resource :applicant_results, only: [:show], path: "/results"
    resource :applicant_email_template_preview, only: [:show], path: "/:email_template_id/preview", defaults: {format: :json}
    resources :applicant_emails, only: [:new, :create], path: "/emails"
    resources :comments, only: [:index], as: :applicant_comments
    resources :events, only: [:index], as: :applicant_events
  end

  resources :campaigns
  scope "/campaigns/:campaign_id" do
    resource :campaign_targeting, only: [:show], path: "/targeting"
    resource :campaign_budget, only: [:show], path: "/budget"
    resource :campaign_dashboards, only: [:show], path: "/overview"
    resources :campaign_properties, only: [:index], path: "/properties"
    resources :versions, only: [:index], as: :campaign_versions, path: "/revisions"
    resources :comments, only: [:index], as: :campaign_comments
    resources :events, only: [:index], as: :campaign_events
  end

  resources :creatives
  scope "/creatives/:creative_id" do
    resources :events, only: [:index], as: :creative_events
    resource :creative_previews, only: [:show], path: "/preview/:template/:theme"
  end

  resources :coupons, except: [:show]

  # this action should semantically be a `create`,
  # but we are using `show` because it renders the pixel image that creates the impression record
  resources :impressions, only: [:show], path: "/display", constraints: ->(req) { req.format == :gif }
  scope "/impressions/:impression_id" do
    # this action should semantically be a `create`
    # we use `show` because it's also a pass through that redirects to the campaign url
    resource :advertisement_clicks, only: [:show], path: "/click"
    resource :impression_uplifts, only: [:create], path: "/uplift"
  end

  # TODO: deprecate legacy support on 2019-04-01
  # Legacy embed script support
  get "/scripts/:legacy_property_id/embed.js", to: "advertisements#show"
  # Legacy impressions api support
  post "/api/v1/impression/:legacy_property_id", to: "advertisements#show", defaults: {format: :json}
  get "/t/s/:legacy_property_id/details", to: "advertisements#show", defaults: {format: :json}

  resources :properties do
    resource :property_screenshots, only: [:update]
  end
  scope "/properties/:property_id" do
    resource :property_instructions, only: [:show], path: "/instructions"
    resource :property_keywords, only: [:show], path: "/keywords"
    resource :property_earnings, only: [:show], path: "/earnings"
    resource :property_dashboards, only: [:show], path: "/overview"
    resources :property_campaigns, only: [:index], path: "/campaigns"
    resources :versions, only: [:index], as: :property_versions, path: "/revisions"
    resource :advertisements, only: [:show], path: "/funder", constraints: ->(req) { [:js, :html, :json].any? req.format }
    resource :advertisement_previews, only: [:show], path: "/preview" if Rails.env.development?
    resources :comments, only: [:index], as: :property_comments
    resources :events, only: [:index], as: :property_events
  end

  get "/invite/:referral_code", to: "referrals#new", as: :invite
  resources :referrals, only: [:index]

  resources :templates
  resources :themes
  resources :users
  resource :user_passwords, only: [:edit, :update], path: "/password"

  scope "/users/:user_id" do
    resources :campaigns, only: [:index], as: :user_campaigns
    resources :properties, only: [:index], as: :user_properties
    resources :creatives, only: [:index], as: :user_creatives
    resources :versions, only: [:index], as: :user_versions, path: "/revisions"
    resources :comments, only: [:index], as: :user_comments
    resources :events, only: [:index], as: :user_events
    resource :identicon, only: [:show], format: :png, as: :user_identicon, path: "/identicon.png"
    resource :impersonations, only: [:update], as: :user_impersonation, path: "/impersonate"
  end
  get "/stop_user_impersonation", to: "impersonations#destroy", as: :stop_user_impersonation

  resource :newsletter_subscription, only: [:create]
  resources :advertisers, only: [:index, :create]
  resources :publishers, only: [:index, :create]

  # IMPORTANT: leave as last route so it doesn't override others
  resources :pages, only: [:show], path: "/"
end
