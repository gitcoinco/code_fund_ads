# == Schema Information
#
# Table name: campaign_bundles
#
#  id                    :bigint           not null, primary key
#  daily_budget_cents    :integer          default(0), not null
#  daily_budget_currency :string           default("USD"), not null
#  end_date              :date
#  name                  :string           not null
#  region_ids            :bigint           default([]), is an Array
#  start_date            :date
#  url                   :text             not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  organization_id       :bigint           not null
#  user_id               :bigint           not null
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

  # relationships .............................................................
  belongs_to :organization
  belongs_to :region
  belongs_to :user
  has_many :campaigns

  # validations ...............................................................
  validates :name, length: {maximum: 255, allow_blank: false}
  validates :region_ids, inclusion: {in: Region.pluck(:id)}
  validate :validate_url

  # callbacks .................................................................
  before_validation :sanitize_region_ids

  # scopes ....................................................................

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  monetize :daily_budget_cents, numericality: {greater_than_or_equal_to: 0}
  accepts_nested_attributes_for :campaigns

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

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
      Digest::MD5.hexdigest(region_ids.join),
    ].compact.join("/")
  end

  # protected instance methods ................................................
  protected

  # private instance methods ..................................................
  private

  def validate_url
    self.url = url.to_s.strip
    URI.parse(url)
  rescue
    errors[:url] << "is invalid"
  end

  def sanitize_region_ids
    self.region_ids = (region_ids & Region.pluck(:id)).sort
  end
end
