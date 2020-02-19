module CampaignBundles
  module Statusable
    extend ActiveSupport::Concern

    STATUSES = ENUMS::CAMPAIGN_BUNDLE_STATUSES

    included do
      # scopes ....................................................................
      scope :configured, -> { where.not id: unconfigured }
      scope :unconfigured, -> {
        where(id: Campaign.with_inactive_creatives.select(:campaign_bundle_id))
          .or(where(id: Campaign.without_creative_ids.select(:campaign_bundle_id)))
      }
    end

    def status
      @status ||= unconfigured? ? STATUSES::UNCONFIGURED : STATUSES::CONFIGURED
    end

    def configured?
      !unconfigured?
    end

    def unconfigured?
      campaigns.with_inactive_creatives.exists? || campaigns.without_creative_ids.exists?
    end
  end
end
