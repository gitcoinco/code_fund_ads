class AdvertisementsController < ApplicationController
  include Untrackable

  protect_from_forgery except: :show
  before_action :set_cors_headers
  before_action :set_no_caching_headers
  # before_action :apply_visitor_rate_limiting
  before_action :set_campaign
  before_action :set_virtual_impression_id
  after_action :create_virtual_impression
  # after_action :cache_visitor_response

  helper_method :template_name, :theme_name

  def show
    return head(:forbidden) unless valid_referer?

    track_event :virtual_impression_initiated

    # DEPRECATE: deprecate legacy support on 2019-04-01
    return render_legacy_show if legacy_api_call?

    set_advertisement_variables

    respond_to do |format|
      format.js
      format.json { render "/advertisements/show", status: @creative ? :ok : :not_found, layout: false }
      format.html { render "/advertisements/show", status: @creative ? :ok : :not_found, layout: false }
      format.svg { head :no_content }
    end
  end

  protected

  def valid_referer?
    return true unless Rails.env.production?

    begin
      return true if request.referer.nil?
      ENUMS::BLOCK_LIST.values.exclude? URI.parse(request.referer)&.host
    rescue URI::InvalidURIError
      true
    end
  end

  # def visitor_cache_key
  #   "advertisements#show/#{Impression.obfuscate_ip_address(ip_address)}"
  # end

  # def apply_visitor_rate_limiting
  #   previous_response = Rails.cache.read(visitor_cache_key)
  #   if previous_response
  #     response.status = previous_response[:status]
  #     response.content_type = previous_response[:content_type]
  #     self.response_body = previous_response[:body]
  #   end
  # end

  # def cache_visitor_response
  #   Rails.cache.write(
  #     visitor_cache_key, {
  #       status: response.status,
  #       content_type: response.content_type,
  #       body: response.body,
  #     },
  #     expires_in: (ENV["VISITOR_AD_RATE_LIMIT"] || 2).to_i.seconds
  #   )
  # end

  def set_advertisement_variables
    @target = params[:target] || "codefund_ad"
    return unless @campaign

    @creative = choose_creative(@virtual_impression_id, @campaign)
    return unless @creative

    @campaign_url = advertisement_clicks_url(
      @virtual_impression_id,
      campaign_id: @campaign.id,
      creative_id: @creative.id,
      property_id: property.id,
      template: template_name,
      theme: theme_name
    )
    @impression_url = impression_url(@virtual_impression_id, format: :gif)
    @powered_by_url = referral_code ? invite_url(referral_code) : root_url
    @uplift_url = impression_uplifts_url(@virtual_impression_id, advertiser_id: @campaign.user_id)
  end

  def sample_requests_for_scout
    sample_rate = (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
    if rand > sample_rate
      Rails.logger.debug("[Scout] Ignoring request: #{request.original_url}")
      ScoutApm::Transaction.ignore!
    end
  end

  # DEPRECATE: deprecate legacy support on 2019-04-01
  def legacy_api_call?
    return false unless request.format.json?
    request.path.start_with?("/api/v1/impression", "/t/s/")
  end

  # DEPRECATE: deprecate legacy support on 2019-04-01
  def render_legacy_show
    if @campaign && (@creative = choose_creative(@virtual_impression_id, @campaign))
      @campaign_url = advertisement_clicks_url(@virtual_impression_id, campaign_id: @campaign.id)
      @impression_url = impression_url(@virtual_impression_id, template: template_name, theme: theme_name, format: :gif)
    else
      response.status = :not_found
    end

    render "/advertisements/legacy_show"
  end

  # DEPRECATE: Wrap this IP assignment to only be allowed when API is enabled for
  #       the publisher instead of using the legacy_property_id as a qualifier
  def ip_address
    @ip_address ||= params[:legacy_property_id].present? ?
      (params[:ip_address] || request.remote_ip) :
      request.remote_ip
  end

  def ip_info
    @ip_info ||= Mmdb.lookup(ip_address)
  end

  def country_code
    return params[:test_country_code] if Rails.env.test? && params.key?(:test_country_code)
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

  # DEPRECATE: deprecate legacy support on 2019-04-01
  def property_id
    params[:legacy_property_id] ||= params[:property_id] if /[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/.match?(params[:property_id].to_s)

    @property_id ||= params[:legacy_property_id].present? ?
      Property.where(legacy_id: params[:legacy_property_id]).pluck(:id).first.to_i :
      params[:property_id].to_i
  end

  def property
    @property ||= Property.find_by(id: property_id)
  end

  def template_name
    return "@responsive_footer" if device_small? && property.show_footer_on_responsive?
    @campaign&.fallback? ? fallback_template_name : premium_template_name
  end

  def theme_name
    @campaign&.fallback? ? fallback_theme_name : premium_theme_name
  end

  def premium_template_name
    @premium_template_name ||= ENUMS::AD_TEMPLATES[params[:template] || property&.ad_template] || "default"
  end

  def premium_theme_name
    @premium_theme_name ||= ENUMS::AD_THEMES[params[:theme] || property&.ad_theme] || "light"
  end

  def fallback_template_name
    @fallback_template_name ||= ENUMS::AD_TEMPLATES[params[:template] || property&.fallback_ad_template] || premium_template_name
  end

  def fallback_theme_name
    @fallback_theme_name ||= ENUMS::AD_THEMES[params[:theme] || property&.fallback_ad_theme] || premium_theme_name
  end

  def keywords
    @keywords ||= params[:keywords].to_s.split(",").map(&:strip).select(&:present?)
  end

  def referral_code
    @referral_code ||= User.referral_code(property.user_id)
  end

  def ad_test?
    (params[:ad_test] || params[:adtest]).to_s == "true" || !!request.local?
  end

  def back_pressure?
    Sidekiq::Queue.new(:impression).size > ENV.fetch("MAX_QUEUE_SIZE", 2500).to_i
  end

  def set_campaign
    return nil if device.bot?
    return nil unless property&.active? || property&.pending?
    return nil if device_small? && property.hide_on_responsive?
    return nil if back_pressure?

    campaign_relation = Campaign.active.available_on(Date.current)
    campaign_relation = campaign_relation.where(weekdays_only: false) if Date.current.on_weekend?
    campaign_relation = campaign_relation.where(core_hours_only: false) if prohibited_hour?
    geo_targeted_campaign_relation = campaign_relation
      .targeted_country_code(country_code)
      .targeted_province_code(province_code)

    @campaign = get_premium_campaign(geo_targeted_campaign_relation) if property.active? && ad_test? == false

    return if property.prohibit_fallback_campaigns?

    @campaign ||= get_paid_fallback_campaign if rand < ENV.fetch("PAID_FALLBACK_PERCENT", 90).to_f / 100
    @campaign ||= get_fallback_campaign(geo_targeted_campaign_relation)
    @campaign ||= get_fallback_campaign(campaign_relation)
    @campaign ||= get_paid_fallback_campaign
  end

  def get_premium_campaign(campaign_relation)
    premium_campaign_relation = if property.restrict_to_assigner_campaigns?
      campaign_relation
        .premium
        .where(id: property.assigner_campaigns)
    else
      campaign_relation
        .premium_with_assigned_property_id(property_id)
        .or(campaign_relation.targeted_premium_for_property_id(property_id, *keywords))
    end

    choose_campaign premium_campaign_relation
  end

  def get_fallback_campaign(campaign_relation)
    fallback_campaign_relation = campaign_relation
      .fallback_with_assigned_property_id(property_id)
      .or(campaign_relation.targeted_fallback_for_property_id(property_id, *keywords))

    if property.assigned_fallback_campaign_ids.present?
      fallback_campaign_relation = fallback_campaign_relation.where(id: property.assigned_fallback_campaign_ids)
    end

    # pre-selected fallback
    campaign = choose_campaign(fallback_campaign_relation, ignore_budgets: true)

    # unpaid fallback
    campaign ||= begin
      fallback_campaign_relation = campaign_relation.fallback_with_assigned_property_id(property_id)
        .or(campaign_relation.without_assigned_property_ids.fallback_for_property_id(property_id))
      if property.assigned_fallback_campaign_ids.present?
        fallback_campaign_relation = fallback_campaign_relation.where(id: property.assigned_fallback_campaign_ids)
      end
      choose_campaign fallback_campaign_relation, ignore_budgets: true
    end

    campaign
  end

  def get_paid_fallback_campaign
    fallback_campaign_relation = Campaign.active.paid_fallback.available_on(Date.current)
      .permitted_for_property_id(property_id).without_assigned_property_ids
    choose_campaign fallback_campaign_relation, ignore_budgets: true
  end

  def choose_campaign(campaign_relation, ignore_budgets: false)
    return campaign_relation.sample if ignore_budgets

    campaigns = campaign_relation.includes(:organization).to_a
    campaigns.select!(&:hourly_budget_available?)
    campaigns.sample
  end

  def choose_creative(impression_id, campaign)
    return nil unless impression_id && campaign
    return Creative.active.find_by(id: campaign.creative_ids.first) if campaign.creative_ids.size == 1
    split_experiment = Split::ExperimentCatalog.find_or_create(campaign.split_test_name, *campaign.split_alternative_names)
    return Creative.active.find_by_split_test_name(split_experiment.winner.name) if split_experiment.winner
    split_user = Split::User.new(impression_id)
    split_trial = Split::Trial.new(user: split_user, experiment: split_experiment)
    split_alternative = split_trial.choose!(self)
    return nil unless split_alternative
    Creative.active.find_by_split_test_name split_alternative.name
  end

  def set_virtual_impression_id
    @virtual_impression_id ||= SecureRandom.uuid
  end

  def track_event(event_name)
    Impression.new(
      id: @virtual_impression_id,
      property: property,
      campaign: @campaign,
      creative: @creative,
      ad_template: template_name,
      ad_theme: theme_name,
      country_code: country_code
    ).track_event(event_name)
  end

  def create_virtual_impression
    return unless @campaign && @creative

    Rails.cache.write @virtual_impression_id, {
      campaign_id: @campaign.id,
      property_id: property_id,
      creative_id: @creative.id,
      ad_template: template_name,
      ad_theme: theme_name,
      ip_address: ip_address
    }, expires_in: 30.seconds

    track_event :virtual_impression_created
  end
end
