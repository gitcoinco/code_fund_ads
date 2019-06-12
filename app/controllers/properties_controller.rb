class PropertiesController < ApplicationController
  include Sortable

  before_action :authenticate_user!
  before_action :set_property_search, only: [:index]
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:index], if: -> { params[:user_id].present? }
  before_action :set_assignable_fallback_campaigns, only: [:edit]

  def index
    properties = Property.order(order_by).includes(:user, :property_traffic_estimates)
    if authorized_user.can_admin_system?
      properties = properties.where(user: @user) if @user
    else
      properties = properties.where(user: current_user)
    end
    properties = @property_search.apply(properties)
    @pagy, @properties = pagy(properties)

    render "/properties/for_user/index" if @user
  end

  def new
    @property = current_user.properties.build(status: "pending", ad_template: "default", ad_theme: "light")
    set_assignable_fallback_campaigns
  end

  def create
    @property = current_user.properties.build(property_params)
    @property.status = "pending"
    authorize_assigned_fallback_campaign_ids @property

    respond_to do |format|
      if @property.save
        format.html { redirect_to @property, notice: "Property was successfully created." }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @property.assign_attributes(property_params)
    authorize_assigned_fallback_campaign_ids @property

    respond_to do |format|
      if @property.save
        format.html { redirect_to @property, notice: "Property was successfully updated." }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @property.destroy

    respond_to do |format|
      format.html { redirect_to properties_url, notice: "Property was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_property_search
    clear_searches except: :property_search
    @property_search = GlobalID.parse(session[:property_search]).find if session[:property_search].present?
    @property_search ||= PropertySearch.new
  end

  def set_property
    @property = if authorized_user.can_admin_system?
      Property.find(params[:id])
    else
      current_user.properties.find(params[:id])
    end
  end

  def set_user
    @user = if authorized_user.can_admin_system?
      User.find(params[:user_id])
    else
      current_user
    end
  end

  def set_assignable_fallback_campaigns
    @assignable_fallback_campaigns = if authorized_user.can_admin_system?
      Campaign.active.fallback
    else
      current_user.campaigns.active.fallback
    end
  end

  def property_params
    params.require(:property).permit(
      :ad_template,
      :ad_theme,
      :description,
      :fallback_ad_template,
      :fallback_ad_theme,
      :language,
      :name,
      :prohibit_fallback_campaigns,
      :property_type,
      :responsive_behavior,
      :screenshot,
      :url,
      keywords: [],
      assigned_fallback_campaign_ids: [],
    ).tap do |whitelisted|
      if authorized_user.can_admin_system?
        whitelisted.merge! params.require(:property).permit(
          :restrict_to_assigner_campaigns,
          :revenue_percentage,
          :status,
          prohibited_advertiser_ids: [],
        )
      end
    end
  end

  def sortable_columns
    %w[
      created_at
      name
      status
    ]
  end

  def authorize_assigned_fallback_campaign_ids(property)
    return unless property.assigned_fallback_campaign_ids.present?
    campaigns = Campaign.where(id: property.assigned_fallback_campaign_ids)
    property.assigned_fallback_campaign_ids = campaigns.each_with_object([]) { |campaign, memo|
      next unless authorized_user.can_assign_property_to_campaign?(property, campaign)
      memo << campaign.id
    }
  end
end
