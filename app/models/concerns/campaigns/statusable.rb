# SEE: docs/campaign_statuses.md
module Campaigns
  module Statusable
    extend ActiveSupport::Concern

    STATUSES = ENUMS::CAMPAIGN_STATUSES

    included do
      # validations ...............................................................
      validates :status, inclusion: {in: STATUSES.values}

      # scopes ....................................................................
      scope :accepted, -> { where status: STATUSES::ACCEPTED }
      scope :accepted_or_active, -> { where status: [STATUSES::ACCEPTED, STATUSES::ACTIVE] }
      scope :active, -> { where status: STATUSES::ACTIVE }
      scope :archived, -> { where status: STATUSES::ARCHIVED }
      scope :paused, -> { where status: STATUSES::PAUSED }
      scope :pending, -> { where status: STATUSES::PENDING }
      scope :sold, -> { where status: [STATUSES::ACCEPTED, STATUSES::ACTIVE, STATUSES::PAUSED] }
    end

    def accepted?
      status == STATUSES::ACCEPTED
    end

    def active?
      status == STATUSES::ACTIVE
    end

    def archived?
      status == STATUSES::ARCHIVED
    end

    def paused?
      status == STATUSES::PAUSED
    end

    def pending?
      status == STATUSES::PENDING
    end
  end
end
