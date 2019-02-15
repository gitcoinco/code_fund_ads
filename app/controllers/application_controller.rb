class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Authorizable
  include Dateable

  delegate :instrument, to: ActiveSupport::Notifications

  before_action :reload_extensions, unless: -> { Rails.env.production? }
  before_action -> { cookies.encrypted[:example_id] ||= SecureRandom.uuid }
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_paper_trail_whodunnit
  before_action :set_meta_tag_data
  before_action :sample_requests_for_scout

  impersonates :user

  protected

  # See https://github.com/kpumuk/meta-tags#allowed-options-for-display_meta_tags-and-set_meta_tags-methods
  def set_meta_tag_data
    set_meta_tags(
      site: "CodeFund",
      title: controller_name.to_s.humanize.titleize.gsub("Pages", "Home"),
      description: "CodeFund is an open source platform that helps fund maintainers, bloggers, and builders through non-tracking ethical ads",
      keywords: ["open source", "ethical advertising", "advertising", "fund open source"],
      charset: "utf-8",
      image_src: "https://cdn2.codefund.app/assets/codefund-logo-square-512.png",
      index: true,
      icon: [
        {href: "/favicon.ico", rel: "shortcut icon"},
        {href: "/apple-touch-icon.png", sizes: "180x180", rel: "apple-touch-icon", type: "image/png"},
        {href: "/favicon-32x32.png", sizes: "32x32 96x96", rel: "icon", type: "image/png"},
        {href: "/favicon-16x16.png", sizes: "16x16", rel: "icon", type: "image/png"},
        {href: "/safari-pinned-tab.svg", rel: "mask-icon", color: "#5bbad5", type: "image/svg"},
      ],
      manifest: {href: "/site.webmanifest"},
      alternate: [
        {href: "https://blog.codefund.app/rss", type: "application/rss+xml", title: "RSS"},
      ],
      "apple-mobile-web-app-title": "CodeFund",
      "application-name": "CodeFund",
      "msapplication-TileColor": "#da532c",
      "theme-color": "#ffffff",
      og: {
        title: :title,
        type: "website",
        url: request.fullpath,
        image: :image_src,
        site_name: "CodeFund",
        locale: "en_US",
        fb: {
          admins: "801507563",
        },
      },
      twitter: {
        card: "photo",
        site: "@codefundio",
      },
      viewport: "width=device-width, initial-scale=1, shrink-to-fit=no"
    )
  end

  def authenticate_administrator!
    return render_forbidden unless AuthorizedUser.new(current_user || User.new).can_admin_system?
  end

  def render_not_found
    render file: Rails.public_path.join("404.html"), status: :not_found, layout: false
  end

  def render_forbidden
    render file: Rails.public_path.join("403.html"), status: :forbidden, layout: false
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:invite, keys: [:first_name, :last_name, :organization_id, roles: []])
  end

  def after_invite_path_for(_inviter, _invitee = nil)
    users_path
  end

  def reload_extensions
    load Rails.root.join("app/lib/extensions.rb")
  end

  def default_value(development: nil, production: nil)
    return production if Rails.env.production?
    development || production
  end

  def sample_requests_for_scout
    # Method to be overridden in high-traffic controllers

    # Sample rate should range from 0-1:
    # * 0: captures no requests
    # * 0.75: captures 75% of requests
    # * 1: captures all requests

    # sample_rate = (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f

    # if rand > sample_rate
    #   Rails.logger.debug("[Scout] Ignoring request: #{request.original_url}")
    #   ScoutApm::Transaction.ignore!
    # end
  end
end
