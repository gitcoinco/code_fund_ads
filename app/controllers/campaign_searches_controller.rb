# frozen_string_literal: true

class CampaignSearchesController < ApplicationController
  before_action :authenticate_user!

  def create
    session[:campaign_search] = CampaignSearch.new(campaign_search_params).to_gid_param
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
        :us_hours_only,
        :user,
        :weekdays_only,
        countries: [],
        keywords: [],
        negative_keywords: [],
        statuses: [],
      )
    end
end
