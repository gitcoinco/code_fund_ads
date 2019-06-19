class AdvertisementClicksController < ApplicationController
  before_action :set_campaign
  after_action :create_click

  def show
    # TODO: handle missing impression/campaign/url
    uri = URI.parse(@campaign.url)
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

  def set_campaign
    @campaign = Campaign.find_by(id: params[:campaign_id])
  end

  def create_click
    CreateClickJob.perform_later(
      params[:impression_id],
      params[:campaign_id],
      Time.current.iso8601,
    )
    ab_finished @campaign.split_test_name
  rescue => e
    Rollbar.error e
  end
end
