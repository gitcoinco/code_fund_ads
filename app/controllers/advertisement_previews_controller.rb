class AdvertisementPreviewsController < ApplicationController
  include AdRenderable
  layout false
  protect_from_forgery unless: -> { request.format.js? }
  before_action :authenticate_administrator!
  before_action :set_cors_headers
  before_action :set_no_caching_headers
  before_action :set_campaign, only: [:show]
  before_action :set_creative, only: [:show]

  def index
    @campaigns = Campaign.active.order(:id)
  end

  def show
    @advertisement_html = render_advertisement_html(template, theme) if request.format.js?
    respond_to do |format|
      format.html
      format.js
    end
  end

  protected

  def template_name
    ENUMS::AD_TEMPLATES[params[:template]]
  end

  def theme_name
    ENUMS::AD_THEMES[params[:theme]]
  end

  private

  def set_campaign
    @campaign ||= Campaign.find(params[:campaign_id])
  end

  def set_creative
    @creative = @campaign.creatives.last
  end
end
