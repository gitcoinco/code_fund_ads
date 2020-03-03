class CampaignsController < ApplicationController
  include Sortable
  include Campaigns::Stashable

  before_action :authenticate_user!
  before_action :authenticate_administrator!, only: [:destroy]
  before_action :set_campaign, except: [:create, :index]
  before_action :set_sortable_columns
  before_action :set_current_organization_for_admin, only: [:show, :edit]
  before_action :authorize_edit!, only: [:edit, :update]
  after_action -> { stash_campaign @campaign }, except: [:index, :destroy]

  def index
    campaigns = Campaign.includes(:organization).where(organization: Current.organization).order(order_by)
    @pagy, @campaigns = pagy(campaigns, items: Pagy::VARS[:items])
  end

  def show
    set_meta_tags @campaign

    payload = {
      resource: {
        dashboard: ENV["METABASE_CAMPAIGN_DASHBOARD_ID"].to_i,
      },
      params: {
        "campaign_id" => @campaign.id,
        "start_date" => @start_date.strftime("%F"),
        "end_date" => @end_date.strftime("%F"),
      },
    }
    token = JWT.encode payload, ENV["METABASE_SECRET_KEY"]

    @iframe_url = ENV["METABASE_SITE_URL"] + "/embed/dashboard/" + token + "#bordered=false&titled=false"
  end

  def edit
    set_meta_tags @campaign
    @user ||= @campaign.user
  end

  def create
    @campaign = Campaign.new(campaign_params)
    @campaign.country_codes = @campaign.country_codes.filter { |code| code.present? }

    respond_to do |format|
      if @campaign.save
        format.html { redirect_to @campaign, notice: "Campaign was successfully created." }
        format.json { render :show, status: :created, location: @campaign }
      else
        format.html { render :new }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @campaign.update(campaign_params)
        format.html { redirect_to @campaign, notice: "Campaign was successfully updated." }
        format.json { render :show, status: :ok, location: @campaign }
      else
        format.html { render :edit }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @campaign.update(status: ENUMS::CAMPAIGN_STATUSES::ARCHIVED)
    respond_to do |format|
      format.html { redirect_to campaigns_url, notice: "Campaign was successfully archived." }
      format.json { head :no_content }
    end
  end

  private

  def set_campaign
    return @campaign ||= stashed_campaign if action_name == "new"
    @campaign ||= if authorized_user.can_admin_system?
      Campaign.find(params[:id])
    else
      Current.organization&.campaigns&.find(params[:id])
    end
  end

  def set_current_organization_for_admin
    return unless authorized_user.can_admin_system?
    Current.organization = @campaign.organization if @campaign.organization
  end

  def campaign_params
    return advertiser_campaign_params if !authorized_user.can_admin_system? && @campaign.fixed_ecpm
    return extended_advertiser_campaign_params unless authorized_user.can_admin_system?
    sanitize_params(:campaign, params).require(:campaign).permit(
      :daily_budget,
      :date_range,
      :ecpm,
      :ecpm_multiplier,
      :fallback,
      :fixed_ecpm,
      :hourly_budget,
      :name,
      :paid_fallback,
      :status,
      :total_budget,
      :url,
      :user_id,
      assigned_property_ids: [],
      audience_ids: [],
      country_codes: [],
      creative_ids: [],
      keywords: [],
      negative_keywords: [],
      prohibited_property_ids: [],
      province_codes: [],
      region_ids: [],
    )
  end

  def advertiser_campaign_params
    sanitize_params(:campaign, params).require(:campaign).permit(
      :name,
      :url,
      creative_ids: [],
    ).tap do |whitelisted|
      case params[:campaign][:status]
      when ENUMS::CAMPAIGN_STATUSES::PAUSED
        whitelisted[:status] = ENUMS::CAMPAIGN_STATUSES::PAUSED if authorized_user.can_pause_campaign?(@campaign)
      when ENUMS::CAMPAIGN_STATUSES::ACTIVE
        whitelisted[:status] = ENUMS::CAMPAIGN_STATUSES::ACTIVE if authorized_user.can_activate_campaign?(@campaign)
      end
    end
  end

  def extended_advertiser_campaign_params
    sanitize_params(:campaign, params).require(:campaign).permit(
      :name,
      :url,
      country_codes: [],
      creative_ids: [],
      keywords: [],
      negative_keywords: [],
      province_codes: []
    )
  end

  def set_sortable_columns
    @sortable_columns ||= sortable_columns
  end

  def sortable_columns
    %w[
      start_date
      end_date
      name
      updated_at
      created_at
      hourly_budget_cents
      daily_budget_cents
      total_budget_cents
    ]
  end

  def sort_column
    return column if sortable_columns.include?(column)
    "end_date"
  end

  def sort_direction
    @sort_direction ||= %w[asc desc].include?(direction) ? direction : "desc"
  end

  def authorize_edit!
    render_forbidden unless authorized_user(true).can_edit_campaign?(@campaign)
  end
end
