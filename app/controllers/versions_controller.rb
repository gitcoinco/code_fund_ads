class VersionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:index], if: -> { params[:user_id].present? }
  before_action :set_campaign, only: [:index], if: -> { params[:campaign_id].present? }
  before_action :set_property, only: [:index], if: -> { params[:property_id].present? }
  before_action :set_versionable, only: [:show, :update]
  before_action :set_version, only: [:show, :update]

  def index
    @versions = @versionable.versions

    render "/versions/for_user/index"     if @versionable.is_a? User
    render "/versions/for_campaign/index" if @versionable.is_a? Campaign
    render "/versions/for_property/index" if @versionable.is_a? Property
  end

  def show
    render layout: false
  end

  def update
    @versionable = @version.reify
    @versionable.save
    redirect_back fallback_location: root_path, notice: "The changes have been rolled back"
  end

  private

  def set_user
    @versionable = User.find(params[:user_id])
  end

  def set_campaign
    @versionable = Campaign.find(params[:campaign_id])
  end

  def set_property
    @versionable = Property.find(params[:property_id])
  end

  def set_versionable
    @versionable = GlobalID::Locator.locate_signed(params[:sgid])
  end

  def set_version
    @version = @versionable.versions.find(params[:id])
  end
end
