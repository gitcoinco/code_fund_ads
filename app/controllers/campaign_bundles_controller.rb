class CampaignBundlesController < ApplicationController
  include Sortable
  include Scopable
  include CampaignBundles::Stashable

  before_action :authenticate_user!
  before_action :authenticate_administrator!, only: [:new, :create]
  before_action -> { @campaign_bundle ||= stashed_campaign_bundle }, only: :new
  after_action -> { stash_campaign_bundle @campaign_bundle }, only: :new
  before_action :set_campaign_bundle, only: :show

  def index
    campaign_bundles = scope_list(CampaignBundle)
      .order(order_by)
      .includes(:organization)
      .where(organization: Current.organization)
    @pagy, @campaign_bundles = pagy(campaign_bundles, page: @page)
  end

  def new
    @campaign_bundle.assign_attributes organization: Current.organization, user: current_user
    @campaign_bundle.validate
    @campaign_bundle.errors.each do |key, _|
      @campaign_bundle.errors.delete key if key.to_s.start_with?("campaign")
    end
  end

  def create
    @campaign_bundle = CampaignBundle.new(campaign_bundle_params)
    @campaign_bundle.organization = Current.organization
    @campaign_bundle.campaigns.each do |campaign|
      campaign.assign_attributes user_id: @campaign_bundle.user_id, status: ENUMS::CAMPAIGN_STATUSES::ACCEPTED
    end

    respond_to do |format|
      if @campaign_bundle.save
        format.html { redirect_to campaign_bundles_path, notice: "Campaign bundle was successfully created." }
        format.json { render :show, status: :created, location: @campaign_bundle }
      else
        format.html { render :new }
        format.json { render json: @campaign_bundle.errors, status: :unprocessable_entity }
      end
    end
  end

  protected

  def set_campaign_bundle
    @campaign_bundle = if authorized_user(true).can_admin_system?
      CampaignBundle.find(params[:id])
    else
      Current.organization&.campaign_bundles&.find(params[:id])
    end
  end

  def set_sortable_columns
    @sortable_columns ||= %w[
      created_at
      end_date
      start_date
      name
      updated_at
    ]
  end

  def set_scopable_values
    @scopable_values ||= ["all", ENUMS::CAMPAIGN_BUNDLE_STATUSES.values].flatten
  end

  private

  def campaign_bundle_params
    params.require(:campaign_bundle).permit(
      :date_range,
      :name,
      :user_id,
      region_ids: [],
      campaigns_attributes: [:name, :url, :daily_budget, :date_range, :ecpm_multiplier, audience_ids: []]
    )
  end
end
