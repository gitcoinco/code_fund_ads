module DailySummaryReports
  module Presentable
    extend ActiveSupport::Concern

    def country_short_name
      return unless scoped_by_type.inquiry.country_code?
      country = Country.find(scoped_by_id)
      return "#{country.emoji_flag} #{scoped_by_id}" if country
      scoped_by_id
    end
  end
end
