class AdvertisementClicksController < ApplicationController
  after_action :create_click

  def show
    # TODO: handle missing impression/campaign/url
    url = Campaign.where(id: params[:campaign_id]).pluck(:url).first
    uri = URI.parse(url)
    parsed_query = Rack::Utils.parse_query(uri.query)
    query = {
      "utm_campaign" => params[:campaign_id],
      "utm_impression" => params[:impression_id],
      "utm_medium" => "display",
      "utm_referrer" => request.referer,
      "utm_source" => "CodeFund",
    }.merge(parsed_query)
    uri.query = query.to_query
    redirect_to uri.to_s
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
