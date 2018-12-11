# == Schema Information
#
# Table name: impressions
#
#  id                :uuid             not null
#  advertiser_id     :bigint(8)        not null
#  publisher_id      :bigint(8)        not null
#  campaign_id       :bigint(8)        not null
#  creative_id       :bigint(8)        not null
#  property_id       :bigint(8)        not null
#  campaign_name     :string           not null
#  property_name     :string           not null
#  ip_address        :string           not null
#  user_agent        :text             not null
#  country_code      :string
#  postal_code       :string
#  latitude          :decimal(, )
#  longitude         :decimal(, )
#  displayed_at      :datetime         not null
#  displayed_at_date :date             not null
#  clicked_at        :datetime
#  clicked_at_date   :date
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
  before_create :assure_partition_table!, on: [:create]
  after_commit :set_property_advertiser, on: [:create]

  # scopes ....................................................................
  scope :partitioned, ->(advertiser, start_date, end_date = nil) {
    advertiser_id = advertiser.is_a?(User) ? advertiser.id : advertiser
    where(advertiser_id: advertiser_id).between(start_date, end_date || start_date)
  }
  scope :clicked, -> { where.not clicked_at_date: nil }
  scope :on, ->(date) { where displayed_at_date: date.to_date }
  scope :between, ->(start_date, end_date = nil) {
    end_date ? where(displayed_at_date: start_date.to_date..end_date.to_date) : on(start_date)
  }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def clicked?
    clicked_at.present?
  end

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
    Impression.transaction do
      unless partition_table_exists?
        range_start = displayed_at_date.beginning_of_month
        range_end = range_start.end_of_month
        Impression.connection.execute <<~QUERY
          CREATE TABLE public.#{partition_table_name} PARTITION OF public.impressions
          FOR VALUES FROM (#{advertiser_id}, '#{range_start.iso8601}') TO (#{advertiser_id}, '#{range_end.iso8601}');
        QUERY
      end
    end
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

  def assure_campaign_name
    self.campaign_name ||= campaign.scoped_name
  end

  def assure_property_name
    self.property_name ||= property.scoped_name
  end
end
