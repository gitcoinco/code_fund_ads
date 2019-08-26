class AdvertisementClicksController < ApplicationController
  include Untrackable

  before_action :set_variables
  after_action :create_click

  def show
    url = Mustache.render(@campaign.url.to_s, mustache_params)
    uri = URI.parse(url)
    parsed_query = Rack::Utils.parse_query(uri.query)
    query = {
      utm_campaign: params[:campaign_id],
      utm_impression: params[:impression_id],
      utm_medium: "display",
      utm_referrer: request.referer,
      utm_source: "CodeFund",
    }.merge(parsed_query)
    uri.query = query.to_query
    redirect_to uri.to_s
  end

  private

  def set_variables
    @campaign = Campaign.select(:id, :name, :url).find_by(id: params[:campaign_id])
    @creative = Creative.select(:id, :name).find_by(id: params[:creative_id])
    @property = Property.select(:id, :name, :url).find_by(id: params[:property_id])
  end

  def mustache_params
    {
      campaign_id: params[:campaign_id],
      campaign_name: @campaign&.name,
      creative_id: params[:creative_id],
      creative_name: @creative&.name,
      property_id: params[:property_id],
      property_name: @property&.name,
      property_url: @property&.url,
      template: params[:template],
      theme: params[:theme],
    }
  end

  def create_click
    CreateClickJob.perform_later(
      params[:impression_id],
      params[:campaign_id],
      Time.current.iso8601,
    )
  rescue => e
    Rollbar.error e
  end
end
