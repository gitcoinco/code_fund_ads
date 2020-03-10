module Organizations
  module Advertiseable
    extend ActiveSupport::Concern

    def impressions_count_for_organization(start_date = nil, end_date = nil)
      campaigns.map { |c| c.impressions_count(start_date, end_date) }.sum
    end

    def clicks_count_for_organization(start_date = nil, end_date = nil)
      campaigns.map { |c| c.clicks_count(start_date, end_date) }.sum
    end

    def click_rate_for_organization(start_date = nil, end_date = nil)
      impressions_count = impressions_count_for_organization(start_date, end_date)
      return 0 if impressions_count.zero?
      clicks_count = clicks_count_for_organization(start_date, end_date)
      (clicks_count / impressions_count.to_f) * 100
    end
  end
end
