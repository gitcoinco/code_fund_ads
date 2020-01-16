module CampaignBundles
  module Stashable
    extend ActiveSupport::Concern

    def stash_campaign_bundle(campaign_bundle)
      session[:stashed_campaign_bundle] = campaign_bundle&.to_stashable_attributes
    end

    def stashed_campaign_bundle
      CampaignBundle.new stashed_campaign_bundle_params
    end

    def stashed_campaign_bundle_params
      session[:stashed_campaign_bundle] || {}
    end
  end
end
