class CampaignPropertiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_campaign

  def index
    properties = @campaign.properties.order(:name)
    @pagy, @properties = pagy(properties)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end
end
