class CampaignNotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_campaign

  def index
    @notes = @campaign.comment_threads
  end

  def create
    comment = Comment.build_from(@campaign, current_user.id, params[:note])
    comment.save
    redirect_to campaign_campaign_notes_path(@campaign)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end
end
