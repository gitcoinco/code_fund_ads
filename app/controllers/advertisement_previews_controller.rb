class AdvertisementPreviewsController < ApplicationController
  layout false
  before_action :authenticate_administrator!

  def index
    @campaigns = Campaign.active.order(:id)
  end

  def show
    @campaign = Campaign.find(params[:campaign_id])
  end
end
