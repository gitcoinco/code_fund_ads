class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:index], if: -> { params[:user_id].present? }
  before_action :set_campaign, only: [:index], if: -> { params[:campaign_id].present? }
  before_action :set_property, only: [:index], if: -> { params[:property_id].present? }
  before_action :set_creative, only: [:index], if: -> { params[:creative_id].present? }
  before_action :set_eventable, only: [:show, :create]

  def index
    @events = @eventable.events

    render "/events/for_user/index"     if @eventable.is_a? User
    render "/events/for_campaign/index" if @eventable.is_a? Campaign
    render "/events/for_property/index" if @eventable.is_a? Property
    render "/events/for_creative/index" if @eventable.is_a? Creative
  end

  def create
    event = @eventable.add_event(params[:body], params[:tags])
    redirect_back fallback_location: root_path
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_back fallback_location: root_path
  end

  private

  def set_user
    @eventable = User.find(params[:user_id])
  end

  def set_campaign
    @eventable = Campaign.find(params[:campaign_id])
  end

  def set_property
    @eventable = Property.find(params[:property_id])
  end

  def set_creative
    @eventable = Creative.find(params[:creative_id])
  end

  def set_eventable
    @eventable = GlobalID::Locator.locate_signed(params[:sgid])
  end
end
