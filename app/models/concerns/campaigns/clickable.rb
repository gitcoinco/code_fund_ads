module Campaigns
  module Clickable
    extend ActiveSupport::Concern

    TOTAL_CLICKS_COUNT_KEY = "total_clicks_count".freeze
    DAILY_CLICKS_COUNT_KEY = "daily_clicks_count".freeze

    included do
      has_one :total_clicks_counter, -> { where scope: TOTAL_CLICKS_COUNT_KEY }, as: :record, class_name: "Counter"
      has_many :daily_clicks_counters, -> { where scope: DAILY_CLICKS_COUNT_KEY }, as: :record, class_name: "Counter"
      has_many :click_counters

      scope :include_total_clicks_count, -> {
        subquery = Counter.select(:count).for_model(Campaign).scoped_by(TOTAL_CLICKS_COUNT_KEY)
        select(arel_table[Arel.star]).select(subquery.arel.as(TOTAL_CLICKS_COUNT_KEY))
      }

      scope :include_total_click_rate, -> {
        impression_count_subquery = Counter.select(:count).for_model(Campaign).scoped_by(Campaigns::Displayable::TOTAL_IMPRESSIONS_COUNT_KEY)
        click_count_subquery = Counter.select(:count).for_model(Campaign).scoped_by(TOTAL_CLICKS_COUNT_KEY)
        divide = Arel::Nodes::NamedFunction.new("div", [click_count_subquery.arel, impression_count_subquery.arel])
        select(arel_table[Arel.star]).select(divide.as("total_click_rate"))
      }

      scope :include_daily_clicks_count, ->(date = nil) {
        date = Date.parse(date || Date.current).to_date
        subquery = Counter.select(:count).for_model(Campaign).scoped_by(DAILY_CLICKS_COUNT_KEY).segmented_by(date.iso8601)
        select(arel_table[Arel.star]).select(subquery.arel.as(DAILY_CLICKS_COUNT_KEY))
      }

      scope :include_daily_click_rate, ->(date = nil) {
        date = Date.parse(date || Date.current).to_date
        impression_count_subquery = Counter.select(:count).for_model(Campaign).scoped_by(Campaigns::Displayable::TOTAL_IMPRESSIONS_COUNT_KEY).segmented_by(date.iso8601)
        click_count_subquery = Counter.select(:count).for_model(Campaign).scoped_by(DAILY_CLICKS_COUNT_KEY).segmented_by(date.iso8601)
        divide = Arel::Nodes::NamedFunction.new("div", [click_count_subquery.arel, impression_count_subquery.arel])
        select(arel_table[Arel.star]).select(divide.as("daily_click_rate"))
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
        click_counters.sum(:count).to_i
      end
    end

    def daily_clicks_count(date = nil)
      date = Date.parse(date || Date.current).to_date
      Rails.cache.fetch daily_clicks_count_cache_key(date), expires_in: (remaining_operative_days + 7).days do
        click_counters.on(date).limit(1).pluck(:count).first.to_i
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
