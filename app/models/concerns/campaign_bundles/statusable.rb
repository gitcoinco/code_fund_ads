module CampaignBundles
  module Statusable
    extend ActiveSupport::Concern

    STATUSES = ENUMS::CAMPAIGN_BUNDLE_STATUSES

    included do
      # scopes ....................................................................
      scope :configured, -> { where id: all.select(&:configured?).map(&:id) }
      scope :unconfigured, -> { where id: all.select(&:unconfigured?).map(&:id) }
    end

    def status
      @status ||= all_campaigns_configured? ? STATUSES::CONFIGURED : STATUSES::UNCONFIGURED
    end

    def all_campaigns_configured?
      campaigns.map(&:active?).all?
    end

    def configured?
      all_campaigns_configured?
    end

    def unconfigured?
      !all_campaigns_configured?
    end
  end
end
