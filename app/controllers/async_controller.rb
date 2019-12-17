class AsyncController < ApplicationController
  layout false
  before_action :authenticate_user!
  before_action :set_campaign, if: -> { params[:campaign_id] }
  before_action :set_property, if: -> { params[:property_id] }
  before_action :set_date, if: -> { params[:date] }

  private

  def property?
    return false unless params[:property_id]
    return true if @property
    current_user.properties.where(id: params[:property_id]).exists?
  end

  def campaign?
    return false unless params[:campaign_id]
    return true if @campaign
    Current.organization&.campaigns&.where(id: params[:campaign_id])&.exists?
  end

  def set_campaign
    @campaign = if authorized_user.can_admin_system? || property?
      Campaign.find(params[:campaign_id])
    else
      Current.organization&.campaigns&.find(params[:campaign_id])
    end
  end

  def set_property
    @property = if authorized_user.can_admin_system? || campaign?
      Property.find(params[:property_id])
    else
      current_user.properties.find(params[:property_id])
    end
  end

  def set_date
    @date = Date.parse(params[:date])
  end
end
