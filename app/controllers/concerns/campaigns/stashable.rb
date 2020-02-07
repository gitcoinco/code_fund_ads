module Campaigns
  module Stashable
    extend ActiveSupport::Concern

    def stash_campaign(campaign)
      session[:stashed_campaign] = campaign&.to_stashable_attributes
    end

    def stashed_campaign
      params = stashed_campaign_params
      campaign = params[:id] ? Campaign.find(params[:id]) : Campaign.new
      campaign.assign_attributes params.except(:id)
      campaign
    end

    def stashed_campaign_params
      HashWithIndifferentAccess.new(
        session[:stashed_campaign] || {
          temporary_id: Campaign.max(:id) + 1,
          status: ENUMS::CAMPAIGN_STATUSES::PENDING,
          start_date: Date.tomorrow,
          ecpm: Money.new(ENV.fetch("BASE_ECPM", 400).to_i, "USD"),
        }
      )
    end
  end
end
