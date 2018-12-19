class AdvertisementsController < ApplicationController
  include AdRenderable

  protect_from_forgery except: :show
  before_action :set_campaign
  before_action :set_virtual_impression_id, if: -> { @campaign.present? }
  after_action :create_virtual_impression, if: -> { @campaign.present? }

  def show
    @target = params[:target] || "codefund_ad"
    if @campaign
      @advertisement_html = render_advertisement
      @campaign_url = advertisement_clicks_url(@virtual_impression_id, campaign_id: @campaign.id)
      @impression_url = impression_url(@virtual_impression_id, format: :gif)
    end

    respond_to { |format| format.js }
  end

  protected

  def set_virtual_impression_id
    @virtual_impression_id ||= SecureRandom.uuid
  end

  def ip_info
    @ip_info ||= MMDB.lookup(request.remote_ip)
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

  def property_id
    @property_id ||= params[:legacy_id].present? ?
      Property.where(legacy_id: params[:legacy_id]).pluck(:id).first.to_i :
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
    id = geo_targeted_campaigns.for_property_id(property_id, *keywords).pluck(:id).sample
    @campaign = Campaign.find(id) if id

    @campaign ||= begin
      id = geo_targeted_campaigns.targeted_fallback_for_property_id(property_id, *keywords).pluck(:id).sample
      @campaign = Campaign.find(id) if id
    end

    @campaign ||= begin
      id = geo_targeted_campaigns.fallback_for_property_id(property_id).pluck(:id).sample
      @campaign = Campaign.find(id) if id
    end
  end

  def geo_targeted_campaigns
    campaigns = Campaign.active.available_on(Date.current)
    campaigns = campaigns.with_all_countries(country_code) if country_code
    campaigns = campaigns.where(weekdays_only: false) if Date.current.on_weekend?
    campaigns = campaigns.where(core_hours_only: false) if prohibited_hour?
    campaigns
  end

  def advertisement_cache_key
    @ad_cache_key ||= "#{@campaign.cache_key}/#{template_cache_key}/#{theme_cache_key}"
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
      ip_address: request.remote_ip,
    }, expires_in: 30.seconds
  end
end
