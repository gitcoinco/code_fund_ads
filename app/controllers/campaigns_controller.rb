class CampaignsController < ApplicationController
  include Sortable

  before_action :authenticate_user!
  before_action :set_campaign_search, only: [:index]
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:index], if: -> { params[:user_id].present? }

  # GET /campaigns
  # GET /campaigns.json
  def index
    campaigns = Campaign.order(order_by).includes(:user, :creative)
    campaigns = campaigns.where(user: @user) if @user
    campaigns = @campaign_search.apply(campaigns)
    @pagy, @campaigns = pagy(campaigns)

    render "/campaigns/for_user/index" if @user
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
  end

  # GET /campaigns/new
  def new
    @campaign = current_user.campaigns.build(status: "pending")
  end

  # GET /campaigns/1/edit
  def edit
    @user ||= @campaign.user
  end

  # POST /campaigns
  # POST /campaigns.json
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

  # PATCH/PUT /campaigns/1
  # PATCH/PUT /campaigns/1.json
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

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
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

  # Use callbacks to share common setup or constraints between actions.
  def set_campaign
    @campaign = Campaign.find(params[:id])
  end

  def set_user
    @user = if params[:user_id] == "me"
      current_user
    else
      User.find(params[:user_id])
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def campaign_params
    params.require(:campaign).permit(
      :user_id,
      :status,
      :name,
      :date_range,
      :url,
      :creative_id,
      :us_hours_only,
      :weekdays_only,
      :ecpm,
      :daily_budget,
      :total_budget,
      countries: [],
      keywords: [],
      negative_keywords: []
    )
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
