class CampaignChangelogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_campaign
  before_action :set_version, only: [:diff, :rollback, :destroy]

  def index
    @versions = @campaign.versions
  end

  def create
    comment = Comment.build_from(@campaign, current_user.id, params[:note])
    comment.save
    redirect_to campaign_campaign_notes_path(@campaign)
  end

  def diff
    render layout: false
  end

  def rollback
    campaign = @version.reify
    campaign.save
    redirect_to campaign_campaign_changelogs_path(campaign)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

  def set_version
    @version = @campaign.versions.find(params[:id])
  end
end
