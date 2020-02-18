module Campaigns
  module Stashable
    extend ActiveSupport::Concern

    def stash_campaign(campaign)
      session[:stashed_campaign] = campaign&.to_stashable_attributes
    end

    def stashed_campaign
      campaign = campaign_id > 0 ? Campaign.find(campaign_id) : Campaign.new
      campaign.assign_attributes stashed_campaign_params.except(:id) unless campaign_changed?
      campaign
    end

    private

    def campaign_id
      p = try(:params) || try(:url_params) || {}
      (p[:controller] == "campaigns" ? p[:id] : p[:campaign_id]).to_i
    end

    def campaign_changed?
      campaign_id != stashed_campaign_params[:id].to_i
    end

    def stashed_campaign_params
      @stashed_campaign_params ||= HashWithIndifferentAccess.new(
        session[:stashed_campaign] || {
          temporary_id: Campaign.maximum(:id) + 1,
          status: ENUMS::CAMPAIGN_STATUSES::PENDING,
          start_date: Date.tomorrow,
          ecpm: Money.new(ENV.fetch("BASE_ECPM", 400).to_i, "USD"),
        }
      )
    end
  end
end
