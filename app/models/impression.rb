# == Schema Information
#
# Table name: impressions
#
#  id                                          :uuid             not null, primary key
#  advertiser_id                               :bigint(8)        not null
#  publisher_id                                :bigint(8)        not null
#  campaign_id                                 :bigint(8)        not null
#  creative_id                                 :bigint(8)        not null
#  property_id                                 :bigint(8)        not null
#  ip_address                                  :string           not null
#  user_agent                                  :text             not null
#  country_code                                :string
#  postal_code                                 :string
#  latitude                                    :decimal(, )
#  longitude                                   :decimal(, )
#  displayed_at                                :datetime         not null
#  displayed_at_date                           :date             not null
#  clicked_at                                  :datetime
#  clicked_at_date                             :date
#  fallback_campaign                           :boolean          default(FALSE), not null
#  estimated_gross_revenue_fractional_cents    :float
#  estimated_property_revenue_fractional_cents :float
#  estimated_house_revenue_fractional_cents    :float
#  ad_template                                 :string
#  ad_theme                                    :string
#  organization_id                             :bigint(8)
#  province_code                               :string
#  uplift                                      :boolean          default(FALSE)
#

class Impression < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :advertiser, class_name: "User", foreign_key: "advertiser_id"
  belongs_to :publisher, class_name: "User", foreign_key: "publisher_id"
  belongs_to :campaign
  belongs_to :creative
  belongs_to :property

  # validations ...............................................................

  # callbacks .................................................................
  before_validation :set_displayed_at, on: [:create]
  before_create :assure_partition_table!
  before_create :calculate_estimated_revenue
  after_commit :set_property_advertiser, on: [:create]

  # scopes ....................................................................
  scope :partitioned, ->(advertiser, start_date, end_date = nil) {
    advertiser_id = advertiser.is_a?(User) ? advertiser.id : advertiser
    where(advertiser_id: advertiser_id).between(start_date, end_date || start_date)
  }
  scope :clicked, -> { where.not clicked_at_date: nil }
  scope :on, ->(*dates) { where displayed_at_date: dates.map { |date| Date.coerce(date) } }
  scope :between, ->(start_date, end_date = nil) {
    where displayed_at_date: Date.coerce(start_date)..Date.coerce(end_date)
  }
  scope :scoped_by, ->(record) {
    case record
    when Campaign then where campaign_id: record.id
    when Property then where property_id: record.id
    else all
    end
  }
  scope :fallback, -> { where fallback_campaign: true }
  scope :premium, -> { where fallback_campaign: false }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  self.primary_key = "id"

  # class methods .............................................................
  class << self
    def partitioned_table_names
      result = connection.execute <<~SQL
        SELECT child.relname child
        FROM pg_inherits
        JOIN pg_class child ON pg_inherits.inhrelid = child.oid
        JOIN pg_class parent ON pg_inherits.inhparent = parent.oid
        WHERE parent.relname = 'impressions'
        ORDER BY child
      SQL
      result.values.flatten
    end

    def detach_partitioned_tables(*partitioned_table_names)
      partitioned_table_names.each do |partitioned_table_name|
        connection.execute <<~SQL
          ALTER TABLE impressions DETACH PARTITION #{connection.quote_table_name partitioned_table_name};
        SQL
      end
    end
  end

  # public instance methods ...................................................

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

  def applicable_ecpm
    @applicable_ecpm ||= campaign.adjusted_ecpm(country_code)
  end

  def calculate_estimated_gross_revenue_fractional_cents
    @calculated_estimated_gross_revenue_fractional_cents ||= applicable_ecpm.cents / 1_000.to_f
  end

  def calculate_estimated_property_revenue_fractional_cents
    @calculated_estimated_property_revenue_fractional_cents ||= calculate_estimated_gross_revenue_fractional_cents * property.revenue_percentage
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
