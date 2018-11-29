module Campaigns
  module Clickable
    extend ActiveSupport::Concern

    TOTAL_CLICKS_COUNT_KEY = "total_clicks_count".freeze
    DAILY_CLICKS_COUNT_KEY = "daily_clicks_count".freeze

    included do
      has_one :total_clicks_counter, -> { where scope: TOTAL_CLICKS_COUNT_KEY }, as: :record, class_name: "Counter"
      has_many :daily_clicks_counters, -> { where scope: DAILY_CLICKS_COUNT_KEY }, as: :record, class_name: "Counter"

      scope :include_total_clicks_count, -> {
        subquery = Counter.select(:count).where(record_type: "Campaign", record_id: arel_table[:id], scope: TOTAL_CLICKS_COUNT_KEY)
        select(arel_table[Arel.star]).select(subquery.arel.as(TOTAL_CLICKS_COUNT_KEY))
      }

      scope :include_daily_clicks_count, ->(date = nil) {
        date ||= Date.current
        subquery = Counter.select(:count).where(record_type: "Campaign", record_id: arel_table[:id], scope: DAILY_CLICKS_COUNT_KEY, segment: date.iso8601)
        select(arel_table[Arel.star]).select(subquery.arel.as(DAILY_CLICKS_COUNT_KEY))
      }
    end

    def total_clicks_count_cache_key
      "#{cache_key}/#{TOTAL_CLICKS_COUNT_KEY}"
    end

    def daily_clicks_count_cache_key(date = nil)
      "#{cache_key}/#{DAILY_CLICKS_COUNT_KEY}/#{(date || Date.current).to_date.iso8601}"
    end

    def total_clicks_count
      Rails.cache.fetch total_clicks_count_cache_key, expires_in: (remaining_operative_days + 7).days do
        counter = total_clicks_counter
        InitializeTotalClicksCountJob.perform_later id unless counter
        counter&.count.to_i
      end
    end

    def daily_clicks_count(date = nil)
      date ||= Date.current
      Rails.cache.fetch daily_clicks_count_cache_key(date), expires_in: 2.days do
        counter = daily_clicks_counters.segmented_by(date.iso8601).first
        InitializeDailyClicksCountJob.perform_later id, date.iso8601 unless counter
        counter&.count.to_i
      end
    end

    def total_ctr
      return 0 if total_impressions_count.zero?
      (total_clicks_count / total_impressions_count.to_f) * 100
    end

    def daily_ctr(date = nil)
      date ||= Date.current
      impressions_count = daily_impressions_count(date)
      clicks_count = daily_clicks_count(date)
      return 0 if impressions_count.zero?
      (clicks_count / impressions_count.to_f) * 100
    end
  end
end
