class CampaignReportsMailer < ApplicationMailer
  default from: "team@codefund.io"
  layout "mailer"

  def campaign_report_email(email, campaign, start_date_string, end_date_string)
    @campaign = campaign
    @start_date = Date.coerce(start_date_string)
    @end_date = Date.coerce(end_date_string)

    workbook = create_report_workbook(@campaign, @start_date, @end_date)
    filename = "campaign-report-#{@campaign.id}-#{@start_date.to_s("yyyymmdd")}-#{@end_date.to_s("yyyymmdd")}.xls"
    Tempfile.open(filename, Rails.root.join("tmp")) do |file|
      workbook.write file
      file.rewind
      attachments[filename] = file.read
    end

    mail to: email, subject: "CodeFund Campaign Report: #{@campaign.name}"
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
