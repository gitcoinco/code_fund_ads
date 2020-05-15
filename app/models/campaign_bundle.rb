# == Schema Information
#
# Table name: campaign_bundles
#
#  id              :bigint           not null, primary key
#  end_date        :date             not null
#  name            :string           not null
#  region_ids      :bigint           default([]), is an Array
#  start_date      :date             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_campaign_bundles_on_end_date    (end_date)
#  index_campaign_bundles_on_name        (lower((name)::text))
#  index_campaign_bundles_on_region_ids  (region_ids) USING gin
#  index_campaign_bundles_on_start_date  (start_date)
#

class CampaignBundle < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  include CampaignBundles::Statusable

  # relationships .............................................................
  belongs_to :organization
  belongs_to :user
  has_many :campaigns

  # validations ...............................................................
  validates :name, length: {maximum: 255, allow_blank: false, message: "is invalid"}
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :region_ids, overlap: {values: Region.all.pluck(:id)}

  # callbacks .................................................................
  before_validation :sanitize_region_ids

  # scopes ....................................................................

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  accepts_nested_attributes_for :campaigns

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def dates
    (start_date..end_date).to_a
  rescue
    nil
  end

  def total_operative_days
    dates ? dates.size : 0
  end

  def total_budget
    Money.new campaigns.to_a.sum(&:total_budget), "USD"
  end

  def init_total_budget
    campaigns.map(&:init_total_budget)
  end

  def to_stashable_attributes
    as_json.merge campaigns_attributes: campaigns.map(&:to_stashable_attributes)
  end

  def average_daily_impressions_count
    Region.average_daily_impressions_count(*regions)
  end

  def regions
    Region.where id: region_ids
  end

  def countries
    Country.where id: country_codes
  end

  def country_codes
    regions.map(&:country_codes).flatten.sort
  end

  def cache_key
    return super if persisted?
    [
      self.class.table_name,
      start_date&.iso8601,
      end_date&.iso8601,
      Digest::MD5.hexdigest(region_ids.join)
    ].compact.join("/")
  end

  def daily_impressions_by_audience
    Audience.all.each_with_object({}) do |audience, memo|
      count = Country.average_daily_impressions_count(countries: countries, audience: audience)
      memo[count] = audience
    end
  end

  # TODO: rename date_range to something more appropriate for ui only concerns like: date_range_string
  #       we should do this because `range` has programmatic meaning and this implementaiton is not it
  def date_range
    return nil unless start_date && end_date
    "#{start_date.to_s "mm/dd/yyyy"} - #{end_date.to_s "mm/dd/yyyy"}"
  end

  # TODO: rename date_range to something more appropriate for ui only concerns like: date_range_string
  #       we should do this because `range` has programmatic meaning and this implementaiton is not it
  def date_range=(value)
    dates = value.split(" - ")
    self.start_date = Date.strptime(dates[0], "%m/%d/%Y")
    self.end_date = Date.strptime(dates[1], "%m/%d/%Y")
  end

  # Reset the bundle dates to match the earliest and latest campaign dates
  def update_dates
    return unless campaigns.present?
    start_date = campaigns.map(&:start_date).min
    end_date = campaigns.map(&:end_date).max
    if persisted?
      update start_date: start_date, end_date: end_date
    else
      self.start_date = start_date if start_date
      self.end_date = end_date if end_date
    end
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
  private

  def sanitize_region_ids
    self.region_ids = (region_ids & Region.pluck(:id)).sort
  end
end
