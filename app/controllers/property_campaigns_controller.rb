class PropertyCampaignsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_property

  def index
    campaigns = @property.matching_campaigns
    @pagy, @campaigns = pagy(campaigns)
  end

  private

  def set_property
    @property = Property.find(params[:property_id])
  end
end
