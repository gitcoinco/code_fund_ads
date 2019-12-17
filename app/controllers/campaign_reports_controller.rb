class CampaignReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_campaign
  before_action :validate_request

  def create
    CampaignReportsMailer.with(campaign_mailer_params).campaign_report_email.deliver_later
    head :ok
  end

  private

  def campaign_report_params
    params.require(:campaign_report).permit(:email)
  end

  def campaign_mailer_params
    {
      to: campaign_report_params[:email],
      campaign: @campaign,
      start_date: @start_date.iso8601,
      end_date: @end_date.iso8601,
    }
  end

  def set_campaign
    @campaign = if authorized_user.can_admin_system?
      Campaign.find(params[:campaign_id])
    else
      Current.organization&.campaigns&.find(params[:campaign_id])
    end
  end

  def validate_request
    head :bad_request unless EmailAddress.valid?(campaign_report_params[:email])
    head :bad_request unless @campaign
    head :bad_request unless @campaign.summary(@start_date, @end_date)
  end
end
