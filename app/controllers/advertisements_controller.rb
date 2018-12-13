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

  def set_virtual_impression_id
    @virtual_impression_id = SecureRandom.uuid
  end

  def ip_info
    @ip_info ||= MMDB.lookup(request.remote_ip)
  end

  def property_id
    return Property.where(legacy_id: params[:legacy_id]).pluck(:id).first if params[:legacy_id].present?
    params[:property_id].to_i
  end

  def set_campaign
    country_code = ip_info&.country&.iso_code
    campaigns = Campaign.active.available_on(Date.current).for_property_id(property_id)
    campaigns = campaigns.with_all_countries(country_code) if country_code
    @campaign = campaigns.limit(10).sample

    if @campaign.nil?
      campaigns = Campaign.active.available_on(Date.current).fallback_for_property_id(property_id)
      campaigns = campaigns.with_all_countries(country_code) if country_code
      @campaign = campaigns.limit(10).sample
    end
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
      ).to_inline_css.strip.gsub(/\s\s|\n/, "")
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
