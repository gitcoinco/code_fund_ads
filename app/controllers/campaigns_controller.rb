class CampaignsController < ApplicationController
  include Sortable

  before_action :authenticate_user!
  before_action :authenticate_administrator!, only: [:destroy]
  before_action :set_user, only: [:index], if: -> { params[:user_id].present? }
  before_action :set_campaign_search, only: [:index]
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]

  def index
    campaigns = Campaign.order(order_by).includes(:user, :creative)
    if authorized_user.can_admin_system?
      campaigns = campaigns.where(user: @user) if @user
    else
      campaigns = campaigns.where(user: current_user)
    end
    campaigns = @campaign_search.apply(campaigns)
    @pagy, @campaigns = pagy(campaigns)

    render "/campaigns/for_user/index" if @user
  end

  def show
    set_meta_tags @campaign
  end

  def new
    @campaign = current_user.campaigns.build(
      status: "pending",
      start_date: Date.tomorrow,
      end_date: 30.days.from_now
    )

    if params[:clone].present?
      cloned_campaign = Campaign.find(params[:clone])
      if cloned_campaign.present?
        @campaign.attributes = cloned_campaign.attributes
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

  def set_campaign_search
    @campaign_search = GlobalID.parse(session[:campaign_search]).find if session[:campaign_search].present?
    @campaign_search ||= CampaignSearch.new
  end

  def set_campaign
    @campaign = if authorized_user.can_admin_system?
      Campaign.find(params[:id])
    else
      current_user.campaigns.find(params[:id])
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
    return advertiser_campaign_params unless authorized_user.can_admin_system?
    params.require(:campaign).permit(
      :user_id,
      :status,
      :name,
      :date_range,
      :url,
      :creative_id,
      :core_hours_only,
      :weekdays_only,
      :ecpm,
      :fixed_ecpm,
      :daily_budget,
      :total_budget,
      :fallback,
      country_codes: [],
      keywords: [],
      negative_keywords: [],
      province_codes: [],
    )
  end

  def advertiser_campaign_params
    params.require(:campaign).permit(:name, :url, :creative_id)
  end

  def sortable_columns
    %w[
      name
      end_date
      total_budget_cents
      status
      created_at
      user.first_name
    ]
  end
end
