module CampaignBundles
  module Stashable
    extend ActiveSupport::Concern

    def stash_campaign_bundle(campaign_bundle)
      session[:stashed_campaign_bundle] = campaign_bundle&.to_stashable_attributes
    end

    def stashed_campaign_bundle
      session[:stashed_campaign_bundle] = nil if !@stimulus_reflex && try(:action_name) == "new"
      CampaignBundle.new(stashed_campaign_bundle_params).tap do |campaign_bundle|
        campaign_bundle.start_date ||= Date.current
        campaign_bundle.end_date ||= 30.days.from_now.to_date
      end
    end

    def stashed_campaign_bundle_params
      session[:stashed_campaign_bundle] || {}
    end
  end
end
