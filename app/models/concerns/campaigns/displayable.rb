module Campaigns
  module Displayable
    extend ActiveSupport::Concern

    TOTAL_IMPRESSIONS_COUNT_KEY = "total_impressions_count".freeze
    DAILY_IMPRESSIONS_COUNT_KEY = "daily_impressions_count".freeze

    included do
      has_one :total_impressions_counter, -> { where scope: TOTAL_IMPRESSIONS_COUNT_KEY }, as: :record, class_name: "Counter"
      has_many :daily_impressions_counters, -> { where scope: DAILY_IMPRESSIONS_COUNT_KEY }, as: :record, class_name: "Counter"

      scope :include_total_impressions_count, -> {
        subquery = Counter.select(:count).for_model(Campaign).scoped_by(TOTAL_IMPRESSIONS_COUNT_KEY)
        select(arel_table[Arel.star]).select(subquery.arel.as(TOTAL_IMPRESSIONS_COUNT_KEY))
      }

      scope :include_daily_impressions_count, ->(date = nil) {
        date = (date ||= Date.current).to_date
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
        counter = total_impressions_counter
        InitializeTotalImpressionsCountJob.perform_later id unless counter
        counter&.count.to_i
      end
    end

    def total_impressions_per_mille
      total_impressions_count / 1_000.to_f
    end

    def daily_impressions_count(date = nil)
      date = (date ||= Date.current).to_date
      Rails.cache.fetch daily_impressions_count_cache_key(date), expires_in: 2.days do
        counter = daily_impressions_counters.segmented_by(date.iso8601).first
        InitializeDailyImpressionsCountJob.perform_later id, date.iso8601 unless counter
        counter&.count.to_i
      end
    end

    def daily_impressions_per_mille
      daily_impressions_count / 1_000.to_f
    end
  end
end
