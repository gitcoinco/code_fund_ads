class AdvertisementClicksController < ApplicationController
  after_action :create_click

  def show
    # TODO: handle missing impression/campaign/url
    subquery = Impression.select(:campaign_id).where(id: params[:impression_id])
    url = Campaign.where(id: subquery).pluck(:url).first
    redirect_to url
  end

  private

  def create_click
    CreateClickJob.perform_later params[:impression_id], Time.current.iso8601
  end
end
