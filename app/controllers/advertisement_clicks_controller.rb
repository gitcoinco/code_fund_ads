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
      utm_campaign: @campaign.id,
      utm_impression: @impression_id,
      utm_referrer: request.referer,
    )
    uri.query = query.merge(parsed_query).to_query
    redirect_to uri.to_s
  end

  private

  def sponsor?
    request.path.include? "/visit-sponsor"
  end

  def set_variables
    @property = Property.select(:id, :name, :url).find_by(id: params[:property_id])

    if sponsor?
      @campaign = @property.current_sponsor_campaign
    else
      @impression_id = params[:impression_id]
      @campaign = Campaign.select(:id, :name, :url).find_by(id: params[:campaign_id])
      @creative = Creative.select(:id, :name).find_by(id: params[:creative_id])
      @template = params[:template]
      @theme = params[:theme]
    end

    redirect_to ENV["WORDPRESS_URL"] unless @campaign
  end

  def mustache_params
    {
      campaign_id: CGI.escape(@campaign&.id.to_s),
      campaign_name: CGI.escape(@campaign&.name.to_s),
      creative_id: CGI.escape(@creative&.id.to_s),
      creative_name: CGI.escape(@creative&.name.to_s),
      property_id: CGI.escape(@property&.id.to_s),
      property_name: CGI.escape(@property&.name.to_s),
      property_url: CGI.escape(@property&.url.to_s),
      template: CGI.escape(@template.to_s),
      theme: CGI.escape(@theme.to_s),
    }
  end

  def create_click
    return unless @campaign

    if sponsor?
      return CreateImpressionAndClickJob.perform_later(
        @campaign.id,
        @property.id,
        request.remote_ip,
        request.user_agent,
        Time.current.iso8601,
      )
    end

    return unless @impression_id

    CreateClickJob.perform_later(
      @impression_id,
      @campaign.id,
      Time.current.iso8601,
    )
  rescue => e
    Rollbar.error e
  end
end
