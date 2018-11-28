# == Schema Information
#
# Table name: impressions
#
#  id                :uuid             not null, primary key
#  campaign_id       :bigint(8)
#  campaign_name     :string
#  property_id       :bigint(8)
#  property_name     :string
#  ip                :string
#  user_agent        :text
#  country_code      :string
#  postal_code       :string
#  latitude          :decimal(, )
#  longitude         :decimal(, )
#  payable           :boolean          default(FALSE), not null
#  reason            :string
#  displayed_at      :datetime
#  displayed_at_date :date
#  clicked_at        :datetime
#  fallback_campaign :boolean          default(FALSE), not null
#

class Impression < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :campaign
  belongs_to :distribution, optional: true
  belongs_to :property

  # validations ...............................................................
  validates :country, length: {maximum: 255}
  validates :ip, length: {maximum: 255, allow_blank: false}
  validates :postal_code, length: {maximum: 255}

  # callbacks .................................................................
  after_commit :increment_counters, on: [:create]

  # scopes ....................................................................
  scope :on, ->(date) { where displayed_at_date: date }

  # This scope may look odd but isolating the date range query like this allows us to
  # optimize for the fastest query that takes advantage of partitioning and indexes
  scope :between, ->(start_date, end_date) {
    where displayed_at_date: (start_date..end_date).map(&:iso8601)
  }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  range_partition_by :displayed_at_date

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  # protected instance methods ................................................

  # private instance methods ..................................................

  private

  def increment_counters
    IncrementTotalImpressionsCountJob.perform_later campaign_id
    IncrementDailyImpressionsCountJob.perform_later campaign_id, Date.current.iso8601
  end
end
