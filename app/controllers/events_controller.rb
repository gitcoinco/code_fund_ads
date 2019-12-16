class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:index], if: -> { params[:user_id].present? }
  before_action :set_organization, only: [:index], if: -> { params[:organization_id].present? }
  before_action :set_campaign, only: [:index], if: -> { params[:campaign_id].present? }
  before_action :set_property, only: [:index], if: -> { params[:property_id].present? }
  before_action :set_creative, only: [:index], if: -> { params[:creative_id].present? }

  def index
    @events = @eventable.events

    render "/events/for_user/index" if @eventable.is_a? User
    render "/events/for_organization/index" if @eventable.is_a? Organization
    render "/events/for_campaign/index" if @eventable.is_a? Campaign
    render "/events/for_property/index" if @eventable.is_a? Property
    render "/events/for_creative/index" if @eventable.is_a? Creative
  end

  private

  def set_user
    @eventable = if authorized_user.can_admin_system?
      User.find(params[:user_id])
    else
      current_user
    end
  end

  def set_organization
    @eventable = Current.organization
  end

  def set_campaign
    @eventable = if authorized_user.can_admin_system?
      Campaign.find(params[:campaign_id])
    else
      Current.organization&.campaigns&.find(params[:campaign_id])
    end
  end

  def set_property
    @eventable = if authorized_user.can_admin_system?
      Property.find(params[:property_id])
    else
      current_user.properties.find(params[:property_id])
    end
  end

  def set_creative
    @eventable = if authorized_user.can_admin_system?
      Creative.find(params[:creative_id])
    else
      Current.organization&.creatives&.find(params[:creative_id])
    end
  end
end
