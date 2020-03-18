class CampaignsMailerPreview < ActionMailer::Preview
  def campaign_paused_email
    CampaignsMailer.campaign_paused_email(Campaign.last, User.last)
  end
end
