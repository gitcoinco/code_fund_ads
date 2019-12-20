class AdvertisementPreviewsController < ApplicationController
  layout false
  protect_from_forgery unless: -> { request.format.js? }
  before_action :authenticate_user!, unless: -> { demo? }
  before_action :authenticate_administrator!, only: [:index]
  before_action :set_cors_headers
  before_action :set_campaign, only: [:show]
  before_action :set_creative, only: [:show]
  before_action :set_no_caching_headers
  helper_method :template_name, :theme_name

  def index
    @campaigns = Campaign.standard.active.order(:name)
  end

  def show
    # NOTE: this show action is overloaded and serves 2 distinct purposes
    # 1. First it renders the HTML that embeds an iframe which includes the ad integration code
    return render("/advertisement_previews/show") if request.format.html?

    # 2. Second it renders the JavaScript to preview the ad
    @campaign ||= Current&.organization&.campaigns&.build(
      id: 0,
      user: current_user,
      name: "Unsaved Preview Campaign",
      creative: @creative,
      creative_ids: [@creative.id]
    )

    @virtual_impression_id = SecureRandom.uuid
    @campaign_url = advertisement_clicks_url(
      @virtual_impression_id,
      campaign_id: @campaign.id,
      creative_id: @creative.id,
      property_id: 0,
      template: template_name,
      theme: theme_name,
    )

    # NOTE: This is a preview. Do not set @impression_url as we don't want to track impressions
    # @impression_url = impression_url(@virtual_impression_id, format: :gif)
    @powered_by_url = root_url
    @uplift_url = impression_uplifts_url(@virtual_impression_id, advertiser_id: @campaign.user_id)

    render "/advertisements/show"
  end

  def template_name
    ENUMS::AD_TEMPLATES[params[:template]]
  end

  def theme_name
    ENUMS::AD_THEMES[params[:theme]]
  end

  def sponsor?
    request.format == "svg"
  end

  private

  def demo?
    Rails.application.routes.recognize_path(request.referrer)[:controller].inquiry.demos? && params[:campaign_id] == ENV["CAMPAIGN_DEMO_ID"]
  end

  def set_campaign
    return nil if params[:campaign_id] == "0"
    @campaign = if authorized_user.can_admin_system? || demo?
      Campaign.find params[:campaign_id]
    else
      Current.organization&.campaigns&.find params[:campaign_id]
    end
  end

  def set_creative
    return @creative = @campaign.creatives.sample unless params[:creative_id]

    @creative = if authorized_user.can_admin_system?
      Creative.find params[:creative_id]
    else
      Current.organization&.creatives&.find params[:creative_id]
    end
  end
end
