# == Schema Information
#
# Table name: impressions
#
#  id                :uuid             not null
#  advertiser_id     :bigint(8)        not null
#  campaign_id       :bigint(8)        not null
#  campaign_name     :string           not null
#  property_id       :bigint(8)        not null
#  property_name     :string           not null
#  ip                :string           not null
#  user_agent        :text             not null
#  country_code      :string
#  postal_code       :string
#  latitude          :decimal(, )
#  longitude         :decimal(, )
#  payable           :boolean          default(FALSE), not null
#  reason            :string
#  displayed_at      :datetime         not null
#  displayed_at_date :date             not null
#  clicked_at        :datetime
#  fallback_campaign :boolean          default(FALSE), not null
#

class Impression < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :advertiser, class_name: "User", foreign_key: "advertiser_id"
  belongs_to :campaign
  belongs_to :distribution, optional: true
  belongs_to :property

  # validations ...............................................................

  # callbacks .................................................................
  before_validation :assure_campaign_name, on: [:create]
  before_validation :assure_property_name, on: [:create]
  before_validation :set_displayed_at, on: [:create]
  before_create :assure_partition_table, on: [:create]
  after_commit :set_property_advertiser, on: [:create]
  after_commit :increment_impressions_counter_cache, on: [:create]
  after_commit :increment_clicks_counter_cache, on: [:update],
    if: -> { clicked_at.present? && previous_changes[:clicked_at] }

  # scopes ....................................................................
  scope :clicked, -> { where.not clicked_at: nil }
  scope :payable, -> { where payable: true }
  scope :unpayable, -> { where payable: false }
  scope :on, ->(date) { where displayed_at_date: date.to_date }
  scope :between, ->(start_date, end_date) { where displayed_at_date: start_date.to_date..end_date.to_date }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def partition_table_name
    return "impressions_default" unless campaign_id && displayed_at_date
    [
      "impressions",
      displayed_at_date.to_s("yyyy_mm"),
      "advertiser",
      advertiser_id.to_i,
    ].join("_")
  end

  def partition_table_exists?
    query = Impression.sanitize_sql_array(["SELECT to_regclass(?)", partition_table_name])
    result = Impression.connection.execute(query)
    !!result.first["to_regclass"]
  end

  def assure_partition_table!
    return if partition_table_exists?
    query = <<~QUERY
      CREATE TABLE public.#{partition_table_name} PARTITION OF public.impressions
      FOR VALUES FROM (#{advertiser_id}, '#{displayed_at_date.beginning_of_month.iso8601}') TO (#{advertiser_id}, '#{displayed_at_date.advance(months: 1).iso8601}');
    QUERY
    Impression.connection.execute query
  end

  # protected instance methods ................................................

  # private instance methods ..................................................

  private

  def increment_impressions_counter_cache
    IncrementImpressionsCountCacheJob.perform_later self
  end

  def increment_clicks_counter_cache
    return unless clicked_at.present?
    return unless previous_changes[:clicked_at]
    return unless previous_changes[:clicked_at][0].nil? && previous_changes[:clicked_at][1].present?
    IncrementClicksCountCacheJob.perform_later self
  end

  def set_property_advertiser
    SetPropertyAdvertiserJob.perform_later property_id, advertiser_id
  end

  def set_displayed_at
    self.displayed_at = Time.current
    self.displayed_at_date = Date.current
  end

  def assure_campaign_name
    self.campaign_name ||= campaign.scoped_name
  end

  def assure_property_name
    self.property_name ||= property.scoped_name
  end
end
