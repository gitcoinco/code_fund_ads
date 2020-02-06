# SEE: docs/campaign_statuses.md
module Campaigns
  module Statusable
    extend ActiveSupport::Concern

    included do
      # validations ...............................................................
      validates :status, inclusion: {in: ENUMS::CAMPAIGN_STATUSES.values}

      # scopes ....................................................................
      scope :accepted, -> { where status: ENUMS::CAMPAIGN_STATUSES::ACCEPTED }
      scope :active, -> { where status: ENUMS::CAMPAIGN_STATUSES::ACTIVE }
      scope :archived, -> { where status: ENUMS::CAMPAIGN_STATUSES::ARCHIVED }
      scope :paused, -> { where status: ENUMS::CAMPAIGN_STATUSES::PAUSED }
      scope :pending, -> { where status: ENUMS::CAMPAIGN_STATUSES::PENDING }
    end

    def accepted?
      status == ENUMS::CAMPAIGN_STATUSES::ACCEPTED
    end

    def active?
      status == ENUMS::CAMPAIGN_STATUSES::ACTIVE
    end

    def archived?
      status == ENUMS::CAMPAIGN_STATUSES::ARCHIVED
    end

    def paused?
      status == ENUMS::CAMPAIGN_STATUSES::PAUSED
    end

    def pending?
      status == ENUMS::CAMPAIGN_STATUSES::PENDING
    end
  end
end
