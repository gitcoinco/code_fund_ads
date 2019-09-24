class CampaignSearchesController < ApplicationController
  before_action :authenticate_user!

  def create
    session[:campaign_search] = CampaignSearch.new(campaign_search_params).to_gid_param
    redirect_to campaigns_path
  end

  def update
    if session[:campaign_search].present?
      campaign_search = GlobalID.parse(session[:campaign_search]).find if session[:campaign_search].present?
      session[:campaign_search] = CampaignSearch.new(campaign_search.to_h(params[:remove])).to_gid_param
    end
    redirect_to campaigns_path
  end

  def destroy
    session[:campaign_search] = CampaignSearch.new.to_gid_param
    redirect_to campaigns_path
  end

  private

  def campaign_search_params
    params.require(:campaign_search).permit(
      :name,
      :fallback,
      :core_hours_only,
      :user,
      :user_id,
      :weekdays_only,
      country_codes: [],
      keywords: [],
      negative_keywords: [],
      province_codes: [],
      statuses: [],
    ).tap do |whitelisted|
      if whitelisted[:fallback] == "paid"
        whitelisted[:fallback] = false
        whitelisted[:paid_fallback] = true
      else
        whitelisted[:paid_fallback] = false
        whitelisted[:fallback] = false if whitelisted[:fallback] == "No"
        whitelisted[:fallback] = true if whitelisted[:fallback] == "Yes"
      end
    end
  end
end
