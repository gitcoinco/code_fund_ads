module Campaigns
  module Reportable
    def daily_reports(start = nil, stop = nil)
      DailySummary.scoped_by(nil).between(start || start_date, stop || end_date)
    end

    def summary_report(start = nil, stop = nil)
      DailySummaryReport.scoped_by_type(nil).between(start || start_date, stop || end_date)[0]
    end

    def property_reports(start = nil, stop = nil)
      DailySummaryReport.scoped_by_type("Property").between(start || start_date, stop || end_date)
    end

    def country_reports(start = nil, stop = nil)
      DailySummaryReport.scoped_by_type("country_code").between(start || start_date, stop || end_date)
    end
  end
end
