module Properties
  module Reportable
    def summary(start = nil, stop = nil, paid: true)
      report = DailySummaryReport.scoped_by(self)
        .where(impressionable_type: "Campaign", impressionable_id: campaign_ids_relation(paid))
        .where(scoped_by_type: "Property", scoped_by_id: id)
        .between(start || start_date, stop || end_date)
        .load

      DailySummaryReport.new(
        impressions_count: report.sum(&:impressions_count),
        clicks_count: report.sum(&:clicks_count),
        gross_revenue_cents: report.sum(&:gross_revenue_cents),
        property_revenue_cents: report.sum(&:property_revenue_cents),
        house_revenue_cents: report.sum(&:house_revenue_cents),
      )
    end

    def earnings(start = nil, stop = nil)
      Money.new daily_summaries.scoped_by(nil).between(start || start_date, stop || end_date).sum(:property_revenue_cents)
    end

    # Daily report -------------------------------------------------------------------------------------------

    def daily_summaries_by_day(start = nil, stop = nil, paid: true)
      DailySummary.scoped_by(self)
        .select(:displayed_at_date)
        .select(DailySummary.arel_table[:unique_ip_addresses_count].sum.as("unique_ip_addresses_count"))
        .select(DailySummary.arel_table[:impressions_count].sum.as("impressions_count"))
        .select(DailySummary.arel_table[:clicks_count].sum.as("clicks_count"))
        .select(DailySummary.arel_table[:gross_revenue_cents].sum.as("gross_revenue_cents"))
        .select(DailySummary.arel_table[:property_revenue_cents].sum.as("property_revenue_cents"))
        .select(DailySummary.arel_table[:house_revenue_cents].sum.as("house_revenue_cents"))
        .where(impressionable_type: "Campaign", impressionable_id: campaign_ids_relation(paid))
        .between(start || start_date, stop || end_date)
        .group(:displayed_at_date)
        .order(:displayed_at_date)
    end

    # Country report -----------------------------------------------------------------------------------------

    # def daily_summary_reports_by_country_code(start = nil, stop = nil)
    #   daily_summary_reports.scoped_by_type("country_code").between(start || start_date, stop || end_date)
    # end

    # Campaign report ----------------------------------------------------------------------------------------

    def daily_summary_reports_by_campaign(start = nil, stop = nil)
      daily_summary_reports.scoped_by_type("Campaign").between(start || start_date, stop || end_date).includes(:scoped_by)
    end

    private

    def campaign_ids_relation(paid = true)
      paid ? Campaign.premium : Campaign.fallback.or(Campaign.paid_fallback)
    end
  end
end
