require "sidekiq/web"
Sidekiq::Web.set :session_secret, Rails.application.credentials[:secret_key_base]

Rails.application.routes.draw do
  %w[403 404 422 500].each do |code|
    get code, controller: :errors, action: :error, code: code
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  authenticate :user, lambda { |user| AuthorizedUser.new(user || User.new).can_admin_system? } do
    mount Sidekiq::Web => "/sidekiq"
    mount Split::Dashboard, at: "/split"
  end
  resources :split_experiments, only: [:update, :destroy]

  root to: "pages#index"

  devise_for :users, controllers: {
    sessions: "sessions",
    invitations: "invitations"
  }

  # resource :global_stats, only: [:show], defaults: {format: :json}

  resources :jobs, only: [:index]
  resources :job_posting_prospects, except: [:index, :destroy], path: "/jobs/listings"
  scope "/jobs/listings/:job_posting_id" do
    resource :job_posting_user, only: [:new, :create], path: "/user"
    resource :job_posting_purchase, only: [:new, :create, :show, :edit, :update], path: "/purchase"
  end
  resources :job_postings, except: [:new, :create], path: "/jobs/directory"

  resource :pricing, only: [:show]
  resource :search, only: [:show], controller: :search
  resources :websites, only: [:index]
  resources :administrator_invitations, only: [:update], path: "/administrator/invitations"
  resource :administrator_dashboards, only: [:show], path: "/dashboards/administrator"
  resource :advertiser_dashboards, only: [:show], path: "/dashboards/advertiser"
  resource :publisher_dashboards, only: [:show], path: "/dashboards/publisher"
  resources :job_posting_searches, only: [:create, :update, :destroy], path: "/jobs/searches"
  resources :applicant_searches, only: [:create, :update, :destroy]

  resources :organizations
  scope "/organization/:organization_id/" do
    resources :organization_transactions, path: "/transactions"
    resources :organization_users, path: "/members", as: :organization_users
    resources :events, only: [:index], as: :organization_events
    resources :versions, only: [:index], as: :organization_versions, path: "/revisions"
    resources :organization_reports, except: [:edit], as: :organization_reports, path: "/reports"
    resources :scheduled_organization_reports, only: [:create, :destroy], as: :scheduled_organization_reports, path: "/scheduled_reports"
  end
  resource :organization_invites, only: [:create]

  scope "/jobs", manage_scope: true do
    resources :job_postings, only: [:index, :edit, :update, :destroy], path: "/manage", as: :manage_job_postings
  end

  # polymorphic based on: app/models/concerns/imageable.rb
  scope "/imageables/:imageable_gid/" do
    resources :images, except: [:show]
  end

  resources :versions, only: [:show, :update]
  resources :audiences, only: [:index]

  resources :campaign_bundles, only: [:new, :create, :index, :show]
  resources :campaigns
  scope "/campaigns/:campaign_id" do
    resources :campaign_reports, only: [:create], path: "/reports"
    resources :campaign_dailies, only: [:index], path: "/dailies"
    resources :campaign_properties, only: [:index, :update], path: "/properties"
    resources :campaign_countries, only: [:index], path: "/countries"
    resources :campaign_creatives, only: [:index], path: "/creatives"
    resources :versions, only: [:index], as: :campaign_versions, path: "/revisions"
    resources :events, only: [:index], as: :campaign_events
  end

  resources :creatives
  scope "/creatives/:creative_id" do
    resources :events, only: [:index], as: :creative_events
    resource :creative_previews, only: [:show], path: "/preview/:template/:theme"
  end

  # this action should semantically be a `create`,
  # but we are using `show` because it renders the pixel image that creates the impression record
  resources :impressions, only: [:show], path: "/display", constraints: ->(req) { req.format == :gif }
  scope "/impressions/:impression_id" do
    # this action should semantically be a `create`
    # we use `show` because it's also a pass through that redirects to the campaign url
    resource :advertisement_clicks, only: [:show], path: "/click"
    resource :impression_uplifts, only: [:create], path: "/uplift"
  end

  # DEPRECATE: deprecate legacy support on 2019-04-01
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
    resource :property_earnings, only: [:show], path: "/earnings"
    resource :property_dashboards, only: [:show], path: "/overview"
    resources :property_campaigns, only: [:index], path: "/campaigns"
    resources :versions, only: [:index], as: :property_versions, path: "/revisions"
    resource :advertisements, only: [:show], path: "/funder", constraints: ->(req) { %w[js html json].include? req.format }
    resource :advertisement_tests, only: [:show], constraints: ->(req) { %w[js html json svg].include? req.format } if Rails.env.test?
    resources :events, only: [:index], as: :property_events
    get "/sponsor", to: "advertisements#show", constraints: ->(req) { req.format == "svg" }, defaults: {format: :svg}, as: :sponsor
    get "/visit-sponsor", to: "advertisement_clicks#show", as: :sponsor_visit
  end

  get "/invite/:referral_code", to: "referrals#new", as: :invite
  resources :referrals, only: [:index]

  resources :templates
  resources :themes
  resources :users
  resource :user_passwords, only: [:edit, :update], path: "/password"

  scope "/users/:user_id" do
    resources :user_campaigns, only: [:index], path: "/campaigns"
    resources :user_properties, only: [:index], path: "/properties"
    resources :creatives, only: [:index], as: :user_creatives
    resources :versions, only: [:index], as: :user_versions, path: "/revisions"
    resources :events, only: [:index], as: :user_events
    resource :identicon, only: [:show], format: :png, as: :user_identicon, path: "/identicon.png"
    resource :impersonations, only: [:update], as: :user_impersonation, path: "/impersonate"
  end
  get "/stop_user_impersonation", to: "impersonations#destroy", as: :stop_user_impersonation

  resource :demo, only: [:show, :update]
  resources :advertisement_previews, param: :campaign_id, only: [:index, :show], path: "ad-previews"
  # NOTE: this is non restful and bad practice (don't do this)
  #       this route is passable for now since it's an admin only page supporting an edge case
  scope "/ad-previews/:campaign_id" do
    resource :iframe, only: [:show], to: "advertisement_previews#iframe", as: :advertisement_preview_iframe
  end

  # async content loaders
  resource :async_campaign_total_remaining_budget, only: [:show]
  resource :async_campaign_total_remaining_budget_stat_card, only: [:show]
  resource :async_campaign_total_consumed_budget_stat_card, only: [:show]
  resource :async_campaign_total_consumed_budget_progress_bar, only: [:show]
  resource :async_campaign_sparkline, only: [:show]
  resource :async_campaign_click_rate, only: [:show]
  resource :async_property_sparkline, only: [:show]
  resource :async_property_click_rate, only: [:show]
  resource :async_property_earnings_row, only: [:show]
  resource :async_property_campaign_row, only: [:show]
  resource :async_property_stat_card, only: [:show]
  resource :async_property_card_footer, only: [:show]
  resource :async_publisher_impressions_count_stat_card, only: [:show]
  resource :async_publisher_clicks_count_stat_card, only: [:show]
  resource :async_publisher_click_rate_stat_card, only: [:show]
  resource :async_publisher_revenue_stat_card, only: [:show]

  resources :wordpress_snippets, only: [:show]
end
