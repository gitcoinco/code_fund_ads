class Country
  UNKNOWN_CPM_MULTIPLER = 0.05

  include ActiveModel::Model
  attr_accessor(
    :region,
    :subregion,
    :name,
    :iso_code,
    :subregion_cpm_multiplier,
    :country_cpm_multiplier,
    :emoji_flag
  )

  class << self
    def data
      @data ||= begin
        Province.all.each_with_object({}) do |province, memo|
          memo[province.country_code] ||= {
            region: province.region,
            subregion: province.subregion,
            name: province.country_name,
            iso_code: province.country_code,
            subregion_cpm_multiplier: province.subregion_cpm_multiplier,
            country_cpm_multiplier: province.country_cpm_multiplier,
            emoji_flag: province.emoji_flag
          }
        end
      end
    end

    def find(id)
      return nil unless data[id.to_s]
      new data[id.to_s]
    end

    def all
      @all ||= data.values.map { |row| new row }
    end

    def where(attributes = {})
      all.select do |record|
        attributes.keys.map { |key|
          next unless record.respond_to?(key)
          expected_value = attributes[key]
          expected_value = [expected_value] unless expected_value.is_a?(Array)
          expected_value.include? record.send(key)
        }.uniq == [true]
      end
    end

    def day_of_week_impressions_counts(start_date, end_date, countries: [], audience: nil)
      # the db query returns total impressions by day of week for the specified date range,
      # but we still need to calculate the average impressions for each week day
      # based on week day counts in the range between start_date and end_date
      # i.e. how many Sundays, Mondays, ... are in the range etc...

      start_date = Date.coerce(start_date)
      end_date = Date.coerce(end_date)

      daily_summaries = DailySummary.between(start_date, end_date).where(impressionable_type: "Property").scoped_by(countries.map(&:iso_code), :country_code)
        .select(Arel::Nodes::NamedFunction.new("DATE_PART", [Arel::Nodes::SqlLiteral.new("'dow'"), DailySummary.arel_table[:displayed_at_date]]).as("day_of_week"))
        .select(DailySummary.arel_table[:impressions_count].sum.as("impressions_count"))
        .group(:day_of_week)
        .order(:day_of_week)
      daily_summaries = daily_summaries.where(impressionable_id: Property.select(:id).where(audience_id: audience.id)) if audience

      results = ApplicationRecord.connection.execute(daily_summaries.to_sql)
      day_of_week_counts = (start_date..end_date).each_with_object({}) { |date, memo|
        memo[date.wday] ||= 0
        memo[date.wday] += 1
      }

      results.each_with_object({}) do |row, memo|
        day_of_week = row["day_of_week"].to_i
        memo[day_of_week] = (row["impressions_count"] / day_of_week_counts[day_of_week].to_f).floor
      end
    end

    def average_day_of_week_impressions_counts(countries: [], audience: nil)
      key = "average_day_of_week_impressions_counts/#{Digest::MD5.hexdigest(countries.map(&:cache_key).join)}/#{audience&.cache_key}"
      Rails.cache.fetch key, expires_in: 1.day do
        day_of_week_impressions_counts(90.days.ago, 1.day.ago, countries: countries, audience: audience)
      end
    end

    def average_daily_impressions_count(countries: [], audience: nil)
      counts = average_day_of_week_impressions_counts(countries: countries, audience: audience)
      return 0 unless counts.size > 0
      (counts.values.sum / counts.size.to_f).floor
    end
  end

  alias id iso_code

  def cache_key
    "Country/#{id}"
  end

  def ecpm(base: nil, multiplier: nil)
    base = Money.new(ENV.fetch("BASE_ECPM", 400).to_i, "USD") unless base.is_a?(Money)
    value = base * (subregion_cpm_multiplier || Country::UNKNOWN_CPM_MULTIPLER)
    value = base * (country_cpm_multiplier || Country::UNKNOWN_CPM_MULTIPLER) if multiplier.to_s == "country"
    value = Monetize.parse("$0.10 USD") if value.cents < 10
    value
  end

  def average_day_of_week_impressions_counts
    Country.average_day_of_week_impressions_counts(countries: [self])
  end

  def average_daily_impressions_count(audience: nil)
    Country.average_daily_impressions_count(countries: [self], audience: audience)
  end
end
