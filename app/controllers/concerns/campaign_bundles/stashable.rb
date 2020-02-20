module CampaignBundles
  module Stashable
    extend ActiveSupport::Concern

    included do
      before_action :reset_stash if is_a?(ApplicationController)
    end

    def stash_campaign_bundle(campaign_bundle)
      session[:stashed_campaign_bundle] = campaign_bundle&.to_stashable_attributes
    end

    def stashed_campaign_bundle
      CampaignBundle.new(stashed_campaign_bundle_params).tap do |campaign_bundle|
        campaign_bundle.start_date ||= Date.current
        campaign_bundle.end_date ||= 30.days.from_now.to_date
      end
    end

    def stashed_campaign_bundle_params
      session[:stashed_campaign_bundle] || {}
    end

    private

    def reset_stash
      return if controller_name == "campaign_bundles"
      return if action_name == "new"
      session[:stashed_campaign_bundle] = nil
    end
  end
end
