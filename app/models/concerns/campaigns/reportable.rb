module Campaigns
  module Reportable
    def daily_reports(start = nil, stop = nil)
      daily_summaries.scoped_by(nil).between(start || start_date, stop || end_date).order(:displayed_at_date)
    end

    def summary_report(start = nil, stop = nil)
      daily_summary_reports.scoped_by_type(nil).between(start || start_date, stop || end_date)[0]
    end

    def property_reports(start = nil, stop = nil)
      daily_summary_reports.scoped_by_type("Property").between(start || start_date, stop || end_date).includes(:scoped_by)
    end

    def creative_reports(start = nil, stop = nil)
      daily_summary_reports.scoped_by_type("Creative").between(start || start_date, stop || end_date).includes(:scoped_by)
    end

    def country_reports(start = nil, stop = nil)
      daily_summary_reports.scoped_by_type("country_code").between(start || start_date, stop || end_date)
    end
  end
end
