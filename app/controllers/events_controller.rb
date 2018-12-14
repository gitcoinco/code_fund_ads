class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:index], if: -> { params[:user_id].present? }
  before_action :set_campaign, only: [:index], if: -> { params[:campaign_id].present? }
  before_action :set_property, only: [:index], if: -> { params[:property_id].present? }
  before_action :set_creative, only: [:index], if: -> { params[:creative_id].present? }
  before_action :set_applicant, only: [:index], if: -> { params[:applicant_id].present? }

  def index
    @events = @eventable.events

    render "/events/for_user/index"      if @eventable.is_a? User
    render "/events/for_campaign/index"  if @eventable.is_a? Campaign
    render "/events/for_property/index"  if @eventable.is_a? Property
    render "/events/for_creative/index"  if @eventable.is_a? Creative
    render "/events/for_applicant/index" if @eventable.is_a? Applicant
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

  def set_applicant
    @eventable = Applicant.find(params[:applicant_id])
  end
end
