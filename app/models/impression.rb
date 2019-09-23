# == Schema Information
#
# Table name: impressions
#
#  id                                          :uuid             not null, primary key
#  advertiser_id                               :bigint           not null
#  publisher_id                                :bigint           not null
#  campaign_id                                 :bigint           not null
#  creative_id                                 :bigint           not null
#  property_id                                 :bigint           not null
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
#  organization_id                             :bigint
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
  belongs_to :creative, optional: true
  belongs_to :property

  # validations ...............................................................

  # callbacks .................................................................
  before_validation :set_displayed_at, on: [:create]
  before_create :assure_partition_table!
  before_create :calculate_estimated_revenue
  before_save :obfuscate_ip_address
  after_commit :set_property_advertiser, on: [:create]

  # scopes ....................................................................
  scope :partitioned, ->(advertiser, start_date, end_date = nil) {
    advertiser_id = advertiser.is_a?(User) ? advertiser.id : advertiser
    where(advertiser_id: advertiser_id).between(start_date, end_date || start_date)
  }
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
    # Returns the names of all tables attached as a partition of the impressions table
    def attached_table_names
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

    # Returns the names of all tables attached as a partition of the impressions table
    # that are old enough to be detached
    def old_attached_table_names(months_retained: 3)
      months_retained = 3 if months_retained < 3
      attached_table_names.select do |attached_table_name|
        _, year, month, _, _ = attached_table_name.split("_")
        next unless year && month
        year.to_i < Date.current.year || (year.to_i == Date.current.year && month.to_i < Date.current.month - months_retained)
      end
    end

    # Returns the names of all tables detached and not acting as a partition of the impressions table
    def detached_table_names
      result = connection.execute <<~SQL
        SELECT table_name
        FROM information_schema.tables
        WHERE table_name ~ '^impressions_.*_advertiser_'
        ORDER BY table_name
      SQL
      table_names = result.values.flatten
      table_names - attached_table_names
    end

    # Attaches the list of table names as a parition of the impressions table
    def attach_tables(*detached_table_names)
      detached_table_names.each do |detached_table_name|
        _, year, month, _, advertiser_id = detached_table_name.split("_")
        displayed_at_date = Date.new(year.to_i, month.to_i)
        range_start = displayed_at_date.beginning_of_month
        range_end = range_start.end_of_month
        connection.execute <<~SQL
          ALTER TABLE impressions
          ATTACH PARTITION #{connection.quote_table_name detached_table_name}
          FOR VALUES FROM (#{advertiser_id}, '#{range_start.iso8601}') TO (#{advertiser_id}, '#{range_end.iso8601}');
        SQL
      end
    end

    # Detaches the list of table names as a parition of the impressions table
    def detach_tables(*attached_table_names)
      attached_table_names.each do |partitioned_table_name|
        connection.execute <<~SQL
          ALTER TABLE impressions DETACH PARTITION #{connection.quote_table_name partitioned_table_name};
        SQL
      end
    end

    # Detaches old partitions of the impressions table
    def detach_old_tables(months_retained: 3)
      months_retained = 3 if months_retained < 3
      detach_tables(*old_attached_table_names(months_retained: months_retained))
    end

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
    return unless TrackImpressionAnalyticsJob.track_property?(property.analytics_key)
    options = {
      "property_key" => property.analytics_key,
      "campaign_key" => campaign&.analytics_key,
      "creative_key" => creative&.analytics_key,
      "ad_template" => ad_template,
      "ad_theme" => ad_theme,
      "country_code" => country_code,
      "gross_revenue" => estimated_gross_revenue_fractional_cents,
    }
    TrackImpressionAnalyticsJob.perform_later id, event_name.to_s, options
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
        range_end = range_start.advance(months: 1)
        Impression.connection.execute <<~QUERY
          CREATE TABLE public.#{partition_table_name} PARTITION OF public.impressions
          FOR VALUES FROM (#{advertiser_id}, '#{range_start.iso8601}') TO (#{advertiser_id}, '#{range_end.iso8601}');
        QUERY
      end
    end
  end

  def applicable_ecpm
    campaign.adjusted_ecpm country_code
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
