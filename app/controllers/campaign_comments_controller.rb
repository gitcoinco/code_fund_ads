class CampaignCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_view!, only: :index
  before_action :set_campaign, only: :index

  def index
    @comments = @campaign.comment_threads.order(created_at: :desc)
  end

  private

  def set_campaign
    @campaign = if authorized_user.can_admin_system?
      Campaign.find(params[:campaign_id])
    else
      Current.organization&.campaigns&.find(params[:campaign_id])
    end
  end

  def authorize_view!
    render_forbidden unless authorized_user.can_view_comments?
  end
end
