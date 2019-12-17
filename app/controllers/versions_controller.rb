class VersionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:index], if: -> { params[:user_id].present? }
  before_action :set_organization, only: [:index], if: -> { params[:organization_id].present? }
  before_action :set_campaign, only: [:index], if: -> { params[:campaign_id].present? }
  before_action :set_property, only: [:index], if: -> { params[:property_id].present? }
  before_action :set_versionable, only: [:show, :update]
  before_action :set_version, only: [:show, :update]

  def index
    @versions = @versionable.versions

    render "/versions/for_user/index" if @versionable.is_a? User
    render "/versions/for_organization/index" if @versionable.is_a? Organization
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
    @versionable = if authorized_user.can_admin_system?
      User.find(params[:user_id])
    else
      current_user
    end
  end

  def set_organization
    @versionable = Current.organization
  end

  def set_campaign
    @versionable = if authorized_user.can_admin_system?
      Campaign.find(params[:campaign_id])
    else
      Current.organization&.campaigns&.find(params[:campaign_id])
    end
  end

  def set_property
    @versionable = if authorized_user.can_admin_system?
      Property.find(params[:property_id])
    else
      current_user.properties.find(params[:property_id])
    end
  end

  def set_versionable
    # TODO: create authorizer and check permissions
    @versionable = GlobalID::Locator.locate_signed(params[:sgid])
  end

  def set_version
    @version = @versionable.versions.find(params[:id])
  end
end
