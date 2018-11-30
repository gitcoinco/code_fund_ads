module Campaigns
  module Displayable
    extend ActiveSupport::Concern

    TOTAL_IMPRESSIONS_COUNT_KEY = "total_impressions_count".freeze
    DAILY_IMPRESSIONS_COUNT_KEY = "daily_impressions_count".freeze

    included do
      has_many :impression_counters

      scope :include_total_impressions_count, -> {
        subquery = ImpressionCounter.for_campaign_model.sum(:count)
        select(arel_table[Arel.star]).select(subquery.arel.as(TOTAL_IMPRESSIONS_COUNT_KEY))
      }

      scope :include_daily_impressions_count, ->(date = nil) {
        date = Date.parse(date || Date.current).to_date
        subquery = Counter.select(:count).for_model(Campaign).scoped_by(DAILY_IMPRESSIONS_COUNT_KEY).segmented_by(date.iso8601)
        select(arel_table[Arel.star]).select(subquery.arel.as(DAILY_IMPRESSIONS_COUNT_KEY))
      }
    end

    def total_impressions_count_cache_key
      "#{cache_key}/#{TOTAL_IMPRESSIONS_COUNT_KEY}"
    end

    def daily_impressions_count_cache_key(date = nil)
      "#{cache_key}/#{DAILY_IMPRESSIONS_COUNT_KEY}/#{(date || Date.current).to_date.iso8601}"
    end

    def total_impressions_count
      Rails.cache.fetch total_impressions_count_cache_key, expires_in: (remaining_operative_days + 7).days do
        impression_counters.sum(:count).to_i
      end
    end

    def total_impressions_per_mille
      total_impressions_count / 1_000.to_f
    end

    def daily_impressions_count(date = nil)
      date = Date.parse(date || Date.current).to_date
      Rails.cache.fetch daily_impressions_count_cache_key(date), expires_in: 2.days do
        impression_counters.on(date).pluck(:count).first.to_i
      end
    end

    def daily_impressions_per_mille
      daily_impressions_count / 1_000.to_f
    end
  end
end
