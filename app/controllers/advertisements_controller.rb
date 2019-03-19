class AdvertisementsController < ApplicationController
  include AdRenderable

  protect_from_forgery except: :show
  before_action :set_cors_headers
  before_action :set_no_caching_headers
  # before_action :apply_visitor_rate_limiting
  before_action :set_campaign
  before_action :set_virtual_impression_id, if: -> { @campaign.present? }
  after_action :create_virtual_impression, if: -> { @campaign.present? }

  def show
    track_event("Visit", {
      property_id: property_id,
      campaign_id: @campaign&.id,
      creative_id: @campaign&.creative_id,
      country_code: country_code.to_s,
    })

    # TODO: deprecate legacy support on 2019-04-01
    return render_legacy_show if legacy_api_call?

    @target = params[:target] || "codefund_ad"

    if @campaign
      referral_code = User.referral_code(property.user_id)
      @advertisement_html = render_advertisement
      @campaign_url = advertisement_clicks_url(@virtual_impression_id, campaign_id: @campaign.id)
      @impression_url = impression_url(@virtual_impression_id, template: template_name, theme: theme_name, format: :gif)
      @powered_by_url = referral_code ? invite_url(referral_code) : root_url
      @uplift_url = impression_uplifts_url(@virtual_impression_id, advertiser_id: @campaign.user_id)
    end

    respond_to do |format|
      format.js
      format.json { render "/advertisements/show", status: @advertisement_html ? :ok : :not_found, layout: false }
      format.html { render "/advertisements/show", status: @advertisement_html ? :ok : :not_found, layout: false }
    end

    # cache_visitor_response
  end

  protected

  # def visitor_cache_key
  #   "advertisements#show/#{ip_address}"
  # end

  # def cache_visitor_response
  #   Rails.cache.write(
  #     visitor_cache_key, {
  #       status: response.status,
  #       content_type: response.content_type,
  #       body: response.body,
  #     },
  #     expires_in: (ENV["VISITOR_AD_RATE_LIMIT"] || 10).to_i.seconds
  #   )
  # end

  # def apply_visitor_rate_limiting
  #   previous_response = Rails.cache.read(visitor_cache_key)
  #   if previous_response
  #     response.status = previous_response[:status]
  #     response.content_type = previous_response[:content_type]
  #     self.response_body = previous_response[:body]
  #   end
  # end

  def sample_requests_for_scout
    sample_rate = (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
    if rand > sample_rate
      Rails.logger.debug("[Scout] Ignoring request: #{request.original_url}")
      ScoutApm::Transaction.ignore!
    end
  end

  # TODO: deprecate legacy support on 2019-04-01
  def legacy_api_call?
    return false unless request.format.json?
    request.path.start_with?("/api/v1/impression", "/t/s/")
  end

  # TODO: deprecate legacy support on 2019-04-01
  def render_legacy_show
    if @campaign
      @campaign_url = advertisement_clicks_url(@virtual_impression_id, campaign_id: @campaign.id)
      @impression_url = impression_url(@virtual_impression_id, template: template_name, theme: theme_name, format: :gif)
      track_event("Render Legacy Ad", {
        status: "success",
        property_id: property_id,
        campaign_id: @campaign&.id,
        creative_id: @campaign&.creative_id,
        country_code: country_code.to_s,
      })
    else
      track_event("Render Legacy Ad", {
        status: "not_found",
        property_id: property_id,
        country_code: country_code.to_s,
      })
      response.status = :not_found
    end

    render "/advertisements/legacy_show"
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
    iso_code = ip_info&.country&.iso_code
    return nil unless iso_code
    Country.find(iso_code)&.iso_code
  end

  def subdivision
    ip_info&.subdivisions&.first&.iso_code
  end

  def province_code
    return nil unless country_code.present? && subdivision.present?
    Province.find("#{country_code}-#{subdivision}")&.iso_code
  end

  def time_zone_name
    ip_info&.location&.time_zone || "UTC"
  end

  def prohibited_hour_start
    ENV.fetch("PROHIBITED_HOUR_START", 0).to_i
  end

  def prohibited_hour_end
    ENV.fetch("PROHIBITED_HOUR_END", 5).to_i
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
    @property ||= Property.find_by(id: property_id)
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
    campaign_relation = Campaign.active.available_on(Date.current)
    campaign_relation = campaign_relation.where(weekdays_only: false) if Date.current.on_weekend?
    campaign_relation = campaign_relation.where(core_hours_only: false) if prohibited_hour?
    geo_targeted_campaign_relation = campaign_relation
      .targeted_country_code(country_code)
      .targeted_province_code(province_code)

    @campaign = get_premium_campaign(geo_targeted_campaign_relation)
    @campaign ||= get_fallback_campaign(geo_targeted_campaign_relation)
    @campaign ||= get_fallback_campaign(campaign_relation)

    unless @campaign
      track_event("Find Campaign", {
        status: "fail",
        property_id: property_id,
        country_code: country_code.to_s,
      })
    end
  end

  def get_premium_campaign(campaign_relation)
    campaign = choose_campaign(campaign_relation.targeted_premium_for_property_id(property_id, *keywords))
    if campaign
      track_event("Find Premium Campaign", {
        status: "success",
        property_id: property_id,
        campaign_id: campaign.id,
        creative_id: campaign.creative_id,
        country_code: country_code.to_s,
      })
    else
      track_event("Find Premium Campaign", {
        status: "fail",
        property_id: property_id,
        country_code: country_code.to_s,
      })
    end
    campaign
  end

  def get_fallback_campaign(campaign_relation)
    campaign = choose_campaign(campaign_relation.targeted_fallback_for_property_id(property_id, *keywords), ignore_budgets: true)
    campaign ||= choose_campaign(campaign_relation.fallback_for_property_id(property_id), ignore_budgets: true)
    if campaign
      track_event("Find Fallback Campaign", {
        status: "success",
        property_id: property_id,
        campaign_id: campaign.id,
        creative_id: campaign.creative_id,
        country_code: country_code.to_s,
      })
    else
      track_event("Find Fallback Campaign", {
        status: "fail",
        property_id: property_id,
        country_code: country_code.to_s,
      })
    end
    campaign
  end

  def choose_campaign(campaign_relation, ignore_budgets: false)
    campaign_relation = campaign_relation.joins(:organization).where(Organization.arel_table[:balance_cents].gt(0)) unless ignore_budgets
    campaigns = campaign_relation.to_a
    campaigns.select! { |campaign| campaign.daily_budget_available? } unless ignore_budgets
    return nil if campaigns.empty?

    ecpm_denominator = campaigns.sum(&:ecpm_cents).to_f
    ecpm_denominator = 0.001 if ecpm_denominator.to_f.zero?
    budget_denominator = campaigns.sum(&:daily_remaining_budget_percentage).to_f unless ignore_budgets
    budget_denominator = 0.001 if budget_denominator.to_f.zero?

    weights = campaigns.map { |campaign|
      province_score = province_code && campaign.province_codes.include?(province_code) ? 0.5 : 0.0
      ecpm_score = (campaign.ecpm_cents / ecpm_denominator).round(2) + 1.0
      budget_score = (campaign.daily_remaining_budget_percentage / budget_denominator).round(2) unless ignore_budgets
      province_score + ecpm_score + budget_score.to_f
    }
    selector = WalkerMethod.new(campaigns, weights)
    campaign = selector.random
    if campaign.nil?
      campaign = campaigns.sample
      logger.info "AdvertisementsController#choose_campaign WalkerMethod failed to find a winner! Choosing a random campaign."
    end
    campaign
  end

  def advertisement_cache_key
    @ad_cache_key ||= "#{@campaign.cache_key_with_version}/#{template_cache_key}/#{theme_cache_key}"
  end

  def render_advertisement
    Rails.cache.fetch(advertisement_cache_key) do
      render_advertisement_html(template, theme, html: request.format.html?)
    end
  end

  def create_virtual_impression
    return unless @campaign

    Rails.cache.write @virtual_impression_id, {
      campaign_id: @campaign.id,
      property_id: property_id,
      ip_address: ip_address,
    }, expires_in: 30.seconds

    track_event("Create Virtual Impression", {
      property_id: property_id,
      campaign_id: @campaign.id,
      creative_id: @campaign.creative_id,
      country_code: country_code.to_s,
    })
  end

  def track_event(name, data)
    CodeFundAds::Events.track(name, session.id, {ip_address: ip_address}.merge(data))
  end
end
