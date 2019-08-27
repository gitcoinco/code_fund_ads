class AdvertisementClicksController < ApplicationController
  include Untrackable

  before_action :set_variables
  after_action :create_click

  def show
    url = Mustache.render(@campaign.url.to_s, mustache_params)
    uri = URI.parse(url)
    parsed_query = Rack::Utils.parse_query(uri.query)
    query = HashWithIndifferentAccess.new(
      utm_source: "CodeFund",
      utm_medium: "display",
      utm_campaign: params[:campaign_id],
      utm_impression: params[:impression_id],
      utm_referrer: request.referer,
    )
    uri.query = query.merge(parsed_query).to_query
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
      campaign_id: CGI.escape(params[:campaign_id].to_s),
      campaign_name: CGI.escape(@campaign&.name.to_s),
      creative_id: CGI.escape(params[:creative_id].to_s),
      creative_name: CGI.escape(@creative&.name.to_s),
      property_id: CGI.escape(params[:property_id].to_s),
      property_name: CGI.escape(@property&.name.to_s),
      property_url: CGI.escape(@property&.url.to_s),
      template: CGI.escape(params[:template].to_s),
      theme: CGI.escape(params[:theme].to_s),
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
