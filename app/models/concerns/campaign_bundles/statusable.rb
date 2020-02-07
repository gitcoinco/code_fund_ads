module CampaignBundles
  module Statusable
    extend ActiveSupport::Concern

    STATUSES = ENUMS::CAMPAIGN_BUNDLE_STATUSES

    included do
      # scopes ....................................................................
      scope :configured, -> { where status: STATUSES::CONFIGURED }
      scope :unconfigured, -> { where status: STATUSES::UNCONFIGURED }
    end

    def status
      @status ||= all_campaigns_configured? ? ENUMS::CAMPAIGN_BUNDLE_STATUSES::CONFIGURED : ENUMS::CAMPAIGN_BUNDLE_STATUSES::UNCONFIGURED
    end

    def all_campaigns_configured?
      campaigns.map(&:active?).all?
    end

    def configured?
      status == STATUSES::CONFIGURED
    end

    def unconfigured?
      status == STATUSES::UNCONFIGURED
    end
  end
end
