module Campaigns
  module Displayable
    extend ActiveSupport::Concern

    TOTAL_IMPRESSIONS_COUNT_KEY = "total_impressions_count".freeze
    DAILY_IMPRESSIONS_COUNT_KEY = "daily_impressions_count".freeze

    included do
      scope :include_total_impressions_count, -> {
        subquery = Impression.select("COUNT(*)").
          where(Impression.arel_table[:advertiser_id].eq(Campaign.arel_table[:user_id])).
          where(Impression.arel_table[:displayed_at_date].gteq(Campaign.arel_table[:start_date])).
          where(Impression.arel_table[:displayed_at_date].lteq(Campaign.arel_table[:end_date]))
        select(arel_table[Arel.star]).select(subquery.arel.as(TOTAL_IMPRESSIONS_COUNT_KEY))
      }

      scope :include_daily_impressions_count, ->(date = nil) {
        date = Date.parse((date || Date.current).to_s).to_date
        subquery = Impression.select("COUNT(*)").
          where(Impression.arel_table[:advertiser_id].eq(Campaign.arel_table[:user_id])).
          where(Impression.arel_table[:displayed_at_date].eq(date))
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
        impressions.count
      end
    end

    def total_impressions_per_mille
      total_impressions_count / 1_000.to_f
    end

    def daily_impressions_count(date = nil)
      date = Date.parse((date || Date.current).to_s).to_date
      Rails.cache.fetch daily_impressions_count_cache_key(date), expires_in: 2.days do
        impressions.on(date).count
      end
    end

    def daily_impressions_per_mille
      daily_impressions_count / 1_000.to_f
    end
  end
end
