class CampaignsController < ApplicationController
  include Sortable
  include Scopable
  include Pagy::Backend

  before_action :authenticate_user!
  before_action :authenticate_administrator!, only: [:destroy]
  before_action :set_user, only: [:index], if: -> { params[:user_id].present? }
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]

  def index
    campaigns = scope_list(Campaign)
      .order(order_by)
      .includes(:user, :creative, :organization)
      .where(organization: Current.organization)
    max = (campaigns.count / Pagy::VARS[:items].to_f).ceil
    @pagy, @campaigns = pagy(campaigns, page: current_page(max: max))

    render "/campaigns/for_user/index" if @user
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

  def new
    @campaign = current_user.campaigns.build(
      status: "pending",
      start_date: Date.tomorrow,
      end_date: 30.days.from_now,
      ecpm: Money.new(ENV.fetch("BASE_ECPM", 400).to_i, "USD")
    )

    if params[:clone].present?
      cloned_campaign = Campaign.find(params[:clone])
      if cloned_campaign.present?
        @campaign.attributes = cloned_campaign.attributes
        @campaign.user = cloned_campaign.user
        @campaign.status = "pending"
      end
    end
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
    @campaign.destroy
    respond_to do |format|
      format.html { redirect_to campaigns_url, notice: "Campaign was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_campaign
    @campaign = if authorized_user.can_admin_system?
      Campaign.find(params[:id])
    else
      Current.organization&.campaigns&.find(params[:id])
    end
  end

  def set_user
    @user = if authorized_user.can_admin_system?
      User.find(params[:user_id])
    else
      current_user
    end
  end

  def campaign_params
    return advertiser_campaign_params if !authorized_user.can_admin_system? && @campaign.fixed_ecpm
    return extended_advertiser_campaign_params unless authorized_user.can_admin_system?
    params.require(:campaign).permit(
      :daily_budget,
      :date_range,
      :ecpm,
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
      country_codes: [],
      creative_ids: [],
      keywords: [],
      negative_keywords: [],
      prohibited_property_ids: [],
      province_codes: [],
    )
  end

  def advertiser_campaign_params
    params.require(:campaign).permit(
      :name,
      :url,
      creative_ids: [],
    )
  end

  def extended_advertiser_campaign_params
    params.require(:campaign).permit(
      :name,
      :url,
      country_codes: [],
      creative_ids: [],
      keywords: [],
      negative_keywords: [],
      province_codes: []
    )
  end

  def sortable_columns
    %w[
      created_at
      end_date
      name
      status
      total_budget_cents
      updated_at
      user.first_name
    ]
  end
end
