# == Schema Information
#
# Table name: impressions
#
#  id                                          :uuid             not null, primary key
#  ad_template                                 :string
#  ad_theme                                    :string
#  clicked_at                                  :datetime
#  clicked_at_date                             :date
#  country_code                                :string
#  displayed_at                                :datetime         not null
#  displayed_at_date                           :date             not null
#  estimated_gross_revenue_fractional_cents    :float
#  estimated_house_revenue_fractional_cents    :float
#  estimated_property_revenue_fractional_cents :float
#  fallback_campaign                           :boolean          default(FALSE), not null
#  ip_address                                  :string           not null
#  latitude                                    :decimal(, )
#  longitude                                   :decimal(, )
#  postal_code                                 :string
#  province_code                               :string
#  uplift                                      :boolean          default(FALSE)
#  user_agent                                  :text             not null
#  advertiser_id                               :bigint           not null
#  campaign_id                                 :bigint           not null
#  creative_id                                 :bigint           not null
#  organization_id                             :bigint
#  property_id                                 :bigint           not null
#  publisher_id                                :bigint           not null
#
# Indexes
#
#  index_impressions_on_ad_template                                 (ad_template)
#  index_impressions_on_ad_theme                                    (ad_theme)
#  index_impressions_on_advertiser_id                               (advertiser_id)
#  index_impressions_on_campaign_id                                 (campaign_id)
#  index_impressions_on_clicked_at_date                             (clicked_at_date)
#  index_impressions_on_clicked_at_hour                             (date_trunc('hour'::text, clicked_at))
#  index_impressions_on_country_code                                (country_code)
#  index_impressions_on_creative_id                                 (creative_id)
#  index_impressions_on_displayed_at_date                           (displayed_at_date)
#  index_impressions_on_displayed_at_hour                           (date_trunc('hour'::text, displayed_at))
#  index_impressions_on_id_and_advertiser_id_and_displayed_at_date  (id,advertiser_id,displayed_at_date) UNIQUE
#  index_impressions_on_organization_id                             (organization_id)
#  index_impressions_on_property_id                                 (property_id)
#  index_impressions_on_province_code                               (province_code)
#  index_impressions_on_uplift                                      (uplift)
#

class Impression < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  include Impressions::Partitionable

  # relationships .............................................................
  belongs_to :organization, optional: true
  belongs_to :advertiser, class_name: "User", foreign_key: "advertiser_id", optional: true
  belongs_to :publisher, class_name: "User", foreign_key: "publisher_id", optional: true
  belongs_to :campaign, optional: true
  belongs_to :creative, optional: true
  belongs_to :property, optional: true
  has_many :pixel_conversions

  # validations ...............................................................

  # callbacks .................................................................
  before_validation :set_displayed_at, on: [:create]
  before_create :calculate_estimated_revenue
  before_save :obfuscate_ip_address
  after_commit :set_property_advertiser, on: [:create]

  # scopes ....................................................................
  scope :clicked, -> { where.not clicked_at_date: nil }
  scope :on, ->(*dates) { where displayed_at_date: dates.map { |date| Date.coerce(date) } }
  scope :between, ->(start_date, end_date = nil) {
    start_date, end_date = range_boundary(start_date) if start_date.is_a?(Range)
    where displayed_at_date: Date.coerce(start_date)..Date.coerce(end_date)
  }
  scope :time_between, ->(start_time, end_time) {
    start_time, end_time = range_boundary(start_time) if start_time.is_a?(Range)
    where displayed_at: start_time.to_time..(end_time || start_time).to_time
  }
  scope :scoped_by, ->(value, type = nil) {
    case value
    when Campaign then where campaign_id: value.id
    when Property then where property_id: value.id
    when Creative then where creative_id: value.id
    when Country then where(country_code: value.iso_code)
    else
      if value.nil? && type.nil?
        all
      elsif columns_hash[type.to_s]
        where type.to_s => value
      else
        none
      end
    end
  }
  scope :fallback, -> { where fallback_campaign: true }
  scope :premium, -> { where fallback_campaign: false }
  scope :standard, -> { where creative_id: Creative.standard }
  scope :sponsor, -> { where creative_id: Creative.sponsor }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  self.primary_key = "id"
  delegate :standard?, :sponsor?, to: :creative

  # class methods .............................................................
  class << self
    def obfuscate_ip_address(ip_address)
      return ip_address unless IPAddress.valid?(ip_address)
      salt = ENV.fetch("IP_ADDRESS_SALT") {
        "038fd0b1517a30d340838541afc0d3cea2899aa67969346d4c0d17d64644de1183033005fcceb149da61a3454f43b7a1c8cbbad4c6953117aa2f0e2a4efb42b9"
      }
      Digest::MD5.hexdigest "#{ip_address}#{salt}"
    end
  end

  # public instance methods ...................................................

  def track_event(event_name)
    # TODO - Re-build for internal CodeFund analytics tool

    # return unless TrackImpressionAnalyticsJob.track_property?(property.analytics_key)
    # options = {
    #   "property_key" => property.analytics_key,
    #   "campaign_key" => campaign&.analytics_key,
    #   "creative_key" => creative&.analytics_key,
    #   "ad_template" => ad_template,
    #   "ad_theme" => ad_theme,
    #   "country_code" => country_code,
    #   "gross_revenue" => estimated_gross_revenue_fractional_cents,
    # }
    # TrackImpressionAnalyticsJob.perform_later id, event_name.to_s, options
  rescue => e
    Rollbar.error e
  end

  def country
    Country.find country_code
  end

  def fallback?
    fallback_campaign?
  end

  def premium?
    !fallback?
  end

  def clicked?
    clicked_at.present?
  end

  def campaign
    @campaign ||= if Rails.env.test?
      super
    else
      key = "#{self.class.name}##{__method__}/#{campaign_id}"
      local_ephemeral_cache.fetch(key, expires_in: 15.minutes) { Campaign.find_by id: campaign_id }
    end
  end

  def property
    @property ||= if Rails.env.test?
      super
    else
      key = "#{self.class.name}##{__method__}/#{property_id}"
      local_ephemeral_cache.fetch(key, expires_in: 15.minutes) { Property.find_by id: property_id }
    end
  end

  def region
    @region ||= if Rails.env.test?
      campaign.regions.with_all_country_codes(country_code).first || Region.other
    else
      key = "#{self.class.name}##{__method__}/#{campaign_id}/#{country_code}"
      local_ephemeral_cache.fetch key, expires_in: 15.minutes do
        match = Region.all.find { |r| campaign.region_ids.include?(r.id) && r.country_codes.include?(country_code) }
        match || Region.other
      end
    end
  end

  def audience
    @audience ||= if Rails.env.test?
      property.audience
    else
      key = "#{self.class.name}##{__method__}/#{property.audience_id}"
      local_ephemeral_cache.fetch key, expires_in: 15.minutes do
        Audience.all.find { |a| a.id == property.audience_id }
      end
    end
  end

  def applicable_ecpm
    return campaign.adjusted_ecpm(country_code) if campaign.campaign_pricing_strategy?

    # region/audience based ecpm i.e. our new sales strategy
    region.ecpm(audience) * campaign.ecpm_multiplier
  end

  def calculate_estimated_gross_revenue_fractional_cents
    applicable_ecpm.cents / 1_000.to_f
  end

  def calculate_estimated_property_revenue_fractional_cents
    calculate_estimated_gross_revenue_fractional_cents * property.revenue_percentage
  end

  def calculate_estimated_house_revenue_fractional_cents
    calculate_estimated_gross_revenue_fractional_cents - calculate_estimated_property_revenue_fractional_cents
  end

  def calculate_estimated_revenue(recalculate = false)
    return unless new_record? || recalculate
    self.estimated_gross_revenue_fractional_cents = calculate_estimated_gross_revenue_fractional_cents
    self.estimated_property_revenue_fractional_cents = calculate_estimated_property_revenue_fractional_cents
    self.estimated_house_revenue_fractional_cents = calculate_estimated_house_revenue_fractional_cents
  end

  def calculate_estimated_revenue_and_save!(recalculate = false)
    calculate_estimated_revenue recalculate
    save! if changed?
  end

  def obfuscate_ip_address
    self.ip_address = self.class.obfuscate_ip_address(ip_address)
  end

  # protected instance methods ................................................

  # private instance methods ..................................................

  private

  def set_property_advertiser
    SetPropertyAdvertiserJob.perform_later property_id, advertiser_id
  end

  def set_displayed_at
    self.displayed_at ||= Time.current
    self.displayed_at_date ||= Date.current
  end
end
