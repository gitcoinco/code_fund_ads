# frozen_string_literal: true

class CampaignSearchesController < ApplicationController
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
        excluded_programming_languages: [],
        excluded_topic_categories: [],
        included_countries: [],
        included_programming_languages: [],
        included_topic_categories: [],
        statuses: [],
      )
    end
end
