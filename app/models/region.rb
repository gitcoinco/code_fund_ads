# == Schema Information
#
# Table name: regions
#
#  id                                        :integer          primary key
#  name                                      :text
#  blockchain_ecpm_currency                  :text
#  blockchain_ecpm_cents                     :integer
#  css_and_design_ecpm_currency              :text
#  css_and_design_ecpm_cents                 :integer
#  dev_ops_ecpm_currency                     :text
#  dev_ops_ecpm_cents                        :integer
#  game_development_ecpm_currency            :text
#  game_development_ecpm_cents               :integer
#  javascript_and_frontend_ecpm_currency     :text
#  javascript_and_frontend_ecpm_cents        :integer
#  miscellaneous_ecpm_currency               :text
#  miscellaneous_ecpm_cents                  :integer
#  mobile_development_ecpm_currency          :text
#  mobile_development_ecpm_cents             :integer
#  web_development_and_backend_ecpm_currency :text
#  web_development_and_backend_ecpm_cents    :integer
#  country_codes                             :text             is an Array
#

class Region < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  include Taggable

  # relationships .............................................................
  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  self.primary_key = :id
  tag_columns :country_codes

  monetize :blockchain_ecpm_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :css_and_design_ecpm_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :dev_ops_ecpm_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :game_development_ecpm_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :javascript_and_frontend_ecpm_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :miscellaneous_ecpm_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :mobile_development_ecpm_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :web_development_and_backend_ecpm_cents, numericality: {greater_than_or_equal_to: 0}

  # class methods .............................................................
  class << self
    def africa
      find 1
    end

    def americas_central_southern
      find 2
    end

    def americas_northern
      find 3
    end

    def asia_central_and_south_eastern
      find 4
    end

    def asia_eastern
      find 5
    end

    def asia_southern_and_western
      find 6
    end

    def australia_and_new_zealand
      find 7
    end

    def europe
      find 8
    end

    def europe_eastern
      find 9
    end

    def other
      find 10
    end

    def daily_impressions_counts(start_date, end_date, *regions)
      results = connection.execute(
        DailySummary.between(start_date, end_date).where(impressionable_type: "Property").scoped_by(regions.map(&:country_codes).flatten, :country_code)
          .select(:displayed_at_date)
          .select(DailySummary.arel_table[:impressions_count].sum.as("impressions_count"))
          .group(:displayed_at_date)
          .order(:displayed_at_date)
          .to_sql
      )
      results.each_with_object({}) do |row, memo|
        memo[Date.coerce(row["displayed_at_date"])] = row["impressions_count"]
      end
    end

    def day_of_week_impressions_counts(start_date, end_date, *regions)
      # the db query returns total impressions by day of week for the specified date range,
      # but we still need to calculate the average impressions for each week day
      # based on week day counts in the range between start_date and end_date
      # i.e. how many Sundays, Mondays, ... are in the range etc...

      start_date = Date.coerce(start_date)
      end_date = Date.coerce(end_date)

      results = connection.execute(
        DailySummary.between(start_date, end_date).where(impressionable_type: "Property").scoped_by(regions.map(&:country_codes).flatten, :country_code)
        .select(Arel::Nodes::NamedFunction.new("DATE_PART", [Arel::Nodes::SqlLiteral.new("'dow'"), DailySummary.arel_table[:displayed_at_date]]).as("day_of_week"))
        .select(DailySummary.arel_table[:impressions_count].sum.as("impressions_count"))
        .group(:day_of_week)
        .order(:day_of_week)
        .to_sql
      )

      day_of_week_counts = (start_date..end_date).each_with_object({}) { |date, memo|
        memo[date.wday] ||= 0
        memo[date.wday] += 1
      }

      results.each_with_object({}) do |row, memo|
        day_of_week = row["day_of_week"].to_i
        memo[day_of_week] = (row["impressions_count"] / day_of_week_counts[day_of_week].to_f).floor
      end
    end

    def average_day_of_week_impressions_counts(*regions)
      day_of_week_impressions_counts(90.days.ago, 1.day.ago, *regions)
    end

    def average_daily_impressions_count(*regions)
      counts = average_day_of_week_impressions_counts(*regions)
      return 0 unless counts.size > 0
      (counts.values.sum / counts.size.to_f).floor
    end
  end

  # public instance methods ...................................................

  def read_only?
    true
  end

  def ecpm(audience)
    public_send audience.ecpm_column_name.delete_suffix("_cents")
  end

  def daily_impressions_counts(start_date, end_date)
    Region.daily_impressions_counts start_date, end_date, self
  end

  def average_day_of_week_impressions_counts
    Region.average_day_of_week_impressions_counts self
  end

  def average_daily_impressions_count
    Region.average_daily_impressions_count self
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
end
