class AsyncController < ApplicationController
  layout false
  before_action :authenticate_user!
  before_action :set_campaign, if: -> { params[:campaign_id] }
  before_action :set_date, if: -> { params[:date] }

  private

  def set_campaign
    @campaign = if authorized_user.can_admin_system?
      Campaign.find(params[:campaign_id])
    else
      current_user.campaigns.find(params[:campaign_id])
    end
  end

  def set_date
    @date = Date.parse(params[:date])
  end
end
