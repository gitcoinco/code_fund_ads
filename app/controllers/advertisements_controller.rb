class AdvertisementsController < ApplicationController
  include AdRenderable

  protect_from_forgery except: :show
  before_action :set_cors_headers
  before_action :set_campaign
  before_action :set_virtual_impression_id, if: -> { @campaign.present? }
  after_action :create_virtual_impression, if: -> { @campaign.present? }

  def show
    # TODO: deprecate legacy support on 2019-04-01
    return render_legacy_show if request.format.json?

    @target = params[:target] || "codefund_ad"

    if @campaign
      @advertisement_html = render_advertisement
      @campaign_url = advertisement_clicks_url(@virtual_impression_id, campaign_id: @campaign.id)
      @impression_url = impression_url(@virtual_impression_id, template: template_name, theme: theme_name, format: :gif)
    end

    respond_to do |format|
      format.js
      format.html { render "/advertisements/show", status: @advertisement_html ? :ok : :not_found, layout: false }
    end
  end

  protected

  # TODO: deprecate legacy support on 2019-04-01
  def render_legacy_show
    if @campaign
      @campaign_url = advertisement_clicks_url(@virtual_impression_id, campaign_id: @campaign.id)
      @impression_url = impression_url(@virtual_impression_id, template: template_name, theme: theme_name, format: :gif)
      instrument "render_legacy_ad.codefund", statsd_key: "web.render_legacy_ad.success"
    else
      instrument "render_legacy_ad.codefund", statsd_key: "web.render_legacy_ad.fail.not_found"
      response.status = :not_found
    end

    respond_to :json
  end

  def set_virtual_impression_id
    @virtual_impression_id ||= SecureRandom.uuid
  end

  # TODO: Wrap this IP assignment to only be allowed when API is enabled for
  #       the publisher instead of using the legacy_property_id as a qualifier
  def ip_address
    @ip_address ||= params[:legacy_property_id].present? ?
      (params[:ip_address] || request.remote_ip) :
      request.remote_ip
  end

  def ip_info
    @ip_info ||= MMDB.lookup(ip_address)
  end

  def country_code
    ip_info&.country&.iso_code
  end

  def time_zone_name
    ip_info&.location&.time_zone || "UTC"
  end

  def prohibited_hour_start
    ENV.fetch("PROHIBITED_HOUR_START") { 0 }.to_i
  end

  def prohibited_hour_end
    ENV.fetch("PROHIBITED_HOUR_END") { 5 }.to_i
  end

  def prohibited_hour?
    hour = begin
             Time.current.in_time_zone(time_zone_name).hour
           rescue
             Time.current.hour
           end
    hour.between? prohibited_hour_start, prohibited_hour_end
  end

  # TODO: deprecate legacy support on 2019-04-01
  def property_id
    params[:legacy_property_id] ||= params[:property_id] if params[:property_id].to_s =~ /[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/

    @property_id ||= params[:legacy_property_id].present? ?
      Property.where(legacy_id: params[:legacy_property_id]).pluck(:id).first.to_i :
      params[:property_id].to_i
  end

  def property
    @property ||= Property.select(:id, :ad_template, :ad_theme, :updated_at).find_by(id: property_id)
  end

  def template_name
    @template_name ||= ENUMS::AD_TEMPLATES[params[:template] || property&.ad_template] || "default"
  end

  def theme_name
    @theme_name ||= ENUMS::AD_THEMES[params[:theme] || property&.ad_theme] || "light"
  end

  def keywords
    @keywords ||= params[:keywords].to_s.split(",").map(&:strip).select(&:present?)
  end

  def set_campaign
    campaign_relation = geo_targeted_campaigns.
      active.available_on(Date.current).
      select(:id, :user_id, :creative_id, :ecpm_currency, :ecpm_cents, :daily_budget_currency, :daily_budget_cents, :fallback, :start_date, :end_date, :updated_at)
    @campaign = choose_campaign(campaign_relation.targeted_premium_for_property_id(property_id, *keywords))
    @campaign ||= choose_campaign(campaign_relation.targeted_fallback_for_property_id(property_id, *keywords), ignore_budgets: true)
    @campaign ||= choose_campaign(campaign_relation.fallback_for_property_id(property_id), ignore_budgets: true)
  end

  def choose_campaign(campaign_relation, ignore_budgets: false)
    unless ignore_budgets
      campaign_relation = campaign_relation.
        joins(:organization).where(Organization.arel_table[:balance_cents].gt(0))
    end
    campaigns = campaign_relation.to_a
    campaigns.select! { |campaign| campaign.daily_budget_available? } unless ignore_budgets
    campaigns.sample
  end

  def geo_targeted_campaigns
    campaigns = Campaign.all
    campaigns = campaigns.with_all_countries(country_code) if country_code
    campaigns = campaigns.where(weekdays_only: false) if Date.current.on_weekend?
    campaigns = campaigns.where(core_hours_only: false) if prohibited_hour?
    campaigns
  end

  def advertisement_cache_key
    @ad_cache_key ||= "#{@campaign.cache_key(:updated_at)}/#{template_cache_key}/#{theme_cache_key}"
  end

  def render_advertisement
    Rails.cache.fetch(advertisement_cache_key) do
      Premailer.new(
        template,
        with_html_string: true,
        html_fragment: true,
        css_string: theme,
        output_encoding: "utf-8",
        adapter: :nokogiri_fast
      ).to_inline_css.strip.gsub(/\s\s|\n/, "").gsub(/\'/, "\\\\'")
    end
  end

  def create_virtual_impression
    return unless @campaign

    Rails.cache.write @virtual_impression_id, {
      campaign_id: @campaign.id,
      property_id: property_id,
      ip_address: ip_address,
    }, expires_in: 30.seconds

    instrument "create_virtual_impression.codefund", statsd_key: "web.create_virtual_impression.success.#{@campaign.id}.#{property_id}"
  end

  def set_cors_headers
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "POST, PUT, DELETE, GET, OPTIONS"
    response.headers["Access-Control-Request-Method"] = "*"
    response.headers["Access-Control-Allow-Headers"] = "Origin, X-Requested-With, Content-Type, Accept, Authorization"
  end
end
