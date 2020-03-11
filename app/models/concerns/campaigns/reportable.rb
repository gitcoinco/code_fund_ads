require "csv"

module Campaigns
  module Reportable
    def summary(start = nil, stop = nil)
      daily_summary_reports.scoped_by_type(nil).between(start || start_date, stop || end_date)[0]
    end

    # Daily report -------------------------------------------------------------------------------------------

    def daily_summaries_by_day(start = nil, stop = nil)
      daily_summaries.scoped_by(nil).between(start || start_date, stop || end_date).order(:displayed_at_date)
    end

    def daily_report(start = nil, stop = nil)
      rows = []
      rows << [
        "Date",
        "Spend",
        "Impressions",
        "Clicks",
        "CTR",
        "CPM",
        "CPC"
      ]
      daily_summaries_by_day(start, stop).each do |daily_summary|
        rows << [
          daily_summary.displayed_at_date.iso8601,
          daily_summary.gross_revenue,
          daily_summary.impressions_count,
          daily_summary.clicks_count,
          daily_summary.click_rate.round(2),
          daily_summary.cpm,
          daily_summary.cpc
        ]
      end
      rows
    end

    def daily_csv(start = nil, stop = nil)
      CSV.generate { |csv| daily_report(start, stop).each { |row| csv << prepare_row_for_download(row) } }
    end

    def daily_worksheet(workbook, start = nil, stop = nil)
      workbook.create_worksheet(name: "Daily").tap do |worksheet|
        daily_report(start, stop).each_with_index do |row, index|
          worksheet.row(index).concat prepare_row_for_download(row)
        end
      end
    end

    # Creative report ----------------------------------------------------------------------------------------

    def daily_summary_reports_by_creative(start = nil, stop = nil)
      daily_summary_reports.scoped_by_type("Creative").between(start || start_date, stop || end_date).includes(:scoped_by)
    end

    def creative_report(start = nil, stop = nil)
      rows = []
      rows << [
        "ID",
        "Name",
        "Spend",
        "Impressions",
        "Clicks",
        "CTR",
        "CPM",
        "CPC"
      ]
      daily_summary_reports_by_creative(start, stop).each do |report|
        rows << [
          report.scoped_by_id,
          report.scoped_by.name,
          report.gross_revenue,
          report.impressions_count,
          report.clicks_count,
          report.click_rate.round(2),
          report.cpm,
          report.cpc
        ]
      end
      rows
    end

    def creative_csv(start = nil, stop = nil)
      CSV.generate { |csv| creative_report(start, stop).each { |row| csv << prepare_row_for_download(row) } }
    end

    def creative_worksheet(workbook, start = nil, stop = nil)
      workbook.create_worksheet(name: "Creative").tap do |worksheet|
        creative_report(start, stop).each_with_index do |row, index|
          worksheet.row(index).concat prepare_row_for_download(row)
        end
      end
    end

    # Property report ----------------------------------------------------------------------------------------

    def daily_summary_reports_by_property(start = nil, stop = nil)
      daily_summary_reports.scoped_by_type("Property").between(start || start_date, stop || end_date)
    end

    def property_report(start = nil, stop = nil)
      rows = []
      rows << [
        "ID",
        "Name",
        "URL",
        "Matching Tags",
        "Spend",
        "Impressions",
        "Clicks",
        "CTR",
        "CPM",
        "CPC"
      ]
      daily_summary_reports_by_property(start, stop).each do |report|
        rows << [
          report.scoped_by_id,
          report.scoped_by.name,
          report.scoped_by.url,
          matching_keywords(report.scoped_by).join("; "),
          report.gross_revenue,
          report.impressions_count,
          report.clicks_count,
          report.click_rate.round(2),
          report.cpm,
          report.cpc
        ]
      end
      rows
    end

    def property_csv(start = nil, stop = nil)
      CSV.generate { |csv| property_report(start, stop).each { |row| csv << prepare_row_for_download(row) } }
    end

    def property_worksheet(workbook, start = nil, stop = nil)
      workbook.create_worksheet(name: "Property").tap do |worksheet|
        property_report(start, stop).each_with_index do |row, index|
          worksheet.row(index).concat prepare_row_for_download(row)
        end
      end
    end

    # Country report -----------------------------------------------------------------------------------------

    def daily_summary_reports_by_country_code(start = nil, stop = nil)
      daily_summary_reports.scoped_by_type("country_code").between(start || start_date, stop || end_date)
    end

    def country_code_report(start = nil, stop = nil)
      rows = []
      rows << [
        "Country",
        "Spend",
        "Impressions",
        "Clicks",
        "CTR",
        "CPM",
        "CPC"
      ]
      daily_summary_reports_by_country_code(start, stop).each do |report|
        rows << [
          report.scoped_by_id,
          report.gross_revenue,
          report.impressions_count,
          report.clicks_count,
          report.click_rate.round(2),
          report.cpm,
          report.cpc
        ]
      end
      rows
    end

    def country_code_csv(start = nil, stop = nil)
      CSV.generate { |csv| country_code_report(start, stop).each { |row| csv << prepare_row_for_download(row) } }
    end

    def country_code_worksheet(workbook, start = nil, stop = nil)
      workbook.create_worksheet(name: "Country").tap do |worksheet|
        country_code_report(start, stop).each_with_index do |row, index|
          worksheet.row(index).concat prepare_row_for_download(row)
        end
      end
    end

    private

    def prepare_row_for_download(row)
      row.map do |value|
        case value
        when Money then value > 0 ? value.to_f : nil
        else value
        end
      end
    end
  end
end
