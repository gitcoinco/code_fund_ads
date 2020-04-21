class PausedCampaignNotificationJob < ApplicationJob
  queue_as :low

  def perform(campaign: nil, previous_status: nil, user: nil)
    @campaign = campaign
    @user = user
    return unless @campaign && @user && previous_status
    return unless previous_status != ENUMS::CAMPAIGN_STATUSES::PAUSED && @campaign.status == ENUMS::CAMPAIGN_STATUSES::PAUSED

    send_slack_notification
    send_email_notification
  end

  private

  def send_slack_notification
    CreateSlackNotificationJob.perform_later text: slack_message
  end

  def slack_message
    ":double_vertical_bar: Campaign #{@campaign.name} just paused by #{@user&.name}. [View Campaign](https://app.codefund.io/campaign/#{@campaign.id})"
  end

  def send_email_notification
    CampaignsMailer.campaign_paused_email(@campaign, @user).deliver_later
  end
end
