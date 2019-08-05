# Preview all emails at http://localhost:3000/rails/mailers/campaign_reports_mailer
class CampaignReportsMailerPreview < ActionMailer::Preview
  def campaign_report_email
    campaign ||= Campaign.active.premium.sample
    params = {
      to: "team@codefund.io",
      campaign: campaign,
      start_date: campaign.start_date.iso8601,
      end_date: campaign.end_date.iso8601,
    }
    CampaignReportsMailer.with(params).campaign_report_email
  end
end
