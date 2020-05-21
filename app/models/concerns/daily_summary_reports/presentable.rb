module DailySummaryReports
  module Presentable
    extend ActiveSupport::Concern

    def country_name
      return unless scoped_by_type.inquiry.country_code?
      country = Country.find(scoped_by_id)
      return "#{country.name} (#{country.iso_code})" if country
      scoped_by_id
    end
  end
end
