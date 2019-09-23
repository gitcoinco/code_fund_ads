class CampaignReportsMailer < ApplicationMailer
  default from: "team@codefund.io"
  layout "mailer"

  def campaign_report_email
    @campaign = params[:campaign]
    @start_date = Date.coerce(params[:start_date])
    @end_date = Date.coerce(params[:end_date])
    @summary = @campaign.summary(@start_date, @end_date)

    workbook = create_report_workbook(@campaign, @start_date, @end_date)
    filename = "campaign-report-#{@campaign.id}-#{@start_date.to_s("yyyymmdd")}-#{@end_date.to_s("yyyymmdd")}.xls"

    Tempfile.open(filename, Rails.root.join("tmp")) do |file|
      workbook.write file
      file.rewind
      attachments[filename] = file.read
    end

    mail to: params[:to], subject: "CodeFund Campaign Report: #{@campaign.analytics_key}"
  end

  private

  def create_report_workbook(campaign, start_date, end_date)
    Spreadsheet::Workbook.new.tap do |workbook|
      campaign.daily_worksheet workbook, start_date, end_date
      campaign.creative_worksheet workbook, start_date, end_date
      campaign.property_worksheet workbook, start_date, end_date
      campaign.country_code_worksheet workbook, start_date, end_date
    end
  end
end
