class CampaignsMailer < ApplicationMailer
  default from: "alerts@codefund.io"

  def campaign_paused_email(campaign, user)
    @campaign = campaign
    @user = user
    mail(
      to: "team@codefund.io",
      from: "alerts@codefund.io",
      subject: "A campaign has been paused by #{@user&.name}"
    )
  end
end
