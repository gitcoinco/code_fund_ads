module Campaigns
  module Stashable
    extend ActiveSupport::Concern

    def stash_campaign(campaign)
      session[:stashed_campaign] = campaign&.to_stashable_attributes
    end

    def stashed_campaign
      Campaign.new stashed_campaign_params
    end

    def stashed_campaign_params
      session[:stashed_campaign] || {}
    end
  end
end
