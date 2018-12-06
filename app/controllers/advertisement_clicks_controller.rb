class AdvertisementClicksController < ApplicationController
  after_action :create_click

  def show
    # TODO: handle missing impression/campaign/url
    url = Campaign.where(id: params[:campaign_id]).pluck(:url).first
    redirect_to url
  end

  private

  def create_click
    CreateClickJob.perform_later(
      params[:impression_id],
      params[:campaign_id],
      Time.current.iso8601,
    )
  end
end
