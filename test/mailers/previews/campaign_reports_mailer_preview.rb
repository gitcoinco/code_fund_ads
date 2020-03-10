# Preview all emails at http://localhost:3000/rails/mailers/campaign_reports_mailer
class CampaignReportsMailerPreview < ActionMailer::Preview
  def organization_report_email
    campaign ||= Campaign.active.premium.sample
    @organization_report = FactoryBot.create(:organization_report, organization: campaign.organization)
    File.open(Rails.root.join("test", "assets", "dummy.pdf")) do |file|
      @organization_report.pdf.attach(io: file, filename: "example-report.pdf", content_type: "application/pdf")
    end

    params = {
      recipients: ["foo@codefund.io", "bar@codefund.io"],
      organization_report_id: @organization_report.id
    }
    CampaignReportsMailer.with(params).organization_report_email
  end

  def campaign_report_email
    campaign ||= Campaign.active.premium.sample
    params = {
      to: "team@codefund.io",
      campaign: campaign,
      start_date: campaign.start_date.iso8601,
      end_date: campaign.end_date.iso8601
    }
    CampaignReportsMailer.with(params).campaign_report_email
  end
end
