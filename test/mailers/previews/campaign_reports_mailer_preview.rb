# Preview all emails at http://localhost:3000/rails/mailers/campaign_reports_mailer
class CampaignReportsMailerPreview < ActionMailer::Preview
  def campaign_report_email
    campaign = Campaign.find(301)
    CampaignReportsMailer.campaign_report_email(
      campaign.user.email,
      campaign,
      "2019-07-01",
      "2019-07-31"
    )
  end
end
