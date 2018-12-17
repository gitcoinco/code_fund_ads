class AdvertisementsController < ApplicationController
  include AdRenderable

  protect_from_forgery except: :show
  before_action :set_campaign
  before_action :set_virtual_impression_id, if: -> { @campaign.present? }
  before_action :set_template_and_theme, if: -> { @campaign.present? }
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

  private

  def theme
    Rails.cache.fetch(theme_cache_key) do
      render_to_string template: "ad_templates/#{template_name}/themes/#{theme_name}.css", layout: false
    end
  end

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
    return Property.where(legacy_id: params[:legacy_id]).pluck(:id).first if params[:legacy_id].present?
    params[:property_id].to_i
  end

  def set_campaign
    @campaign = Campaign.where(id: geo_targeted_campaigns.for_property_id(property_id).pluck(:id).sample).limit(1).first
    @campaign ||= Campaign.where(id: geo_targeted_campaigns.fallback_for_property_id(property_id).pluck(:id).sample).limit(1).first
  end

  def geo_targeted_campaigns
    campaigns = Campaign.active.available_on(Date.current)
    campaigns = campaigns.with_all_countries(country_code) if country_code
    campaigns = campaigns.where(weekdays_only: false) if Date.current.on_weekend?
    campaigns = campaigns.where(core_hours_only: false) if prohibited_hour?
    campaigns
  end

  def set_template_and_theme
    @template_name = params[:template]
    @theme_name = params[:theme]

    unless @template_name && @theme_name
      template_name, theme_name = Property.where(id: property_id).pluck(:ad_template, :ad_theme).first
      @template_name ||= template_name
      @theme_name ||= theme_name
    end

    @template_name ||= "default"
    @theme_name ||= "light"
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
