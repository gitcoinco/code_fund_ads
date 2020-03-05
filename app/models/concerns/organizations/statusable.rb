module Organizations
  module Statusable
    extend ActiveSupport::Concern

    STATUSES = ENUMS::ORGANIZATION_STATUSES

    included do
      # scopes ....................................................................
      scope :active, -> { where(id: Campaign.active.select(:organization_id)) }
      scope :inactive, -> { where.not id: active }
    end

    def status
      @status ||= active? ? STATUSES::ACTIVE : STATUSES::INACTIVE
    end

    def active?
      campaigns.active.exists?
    end

    def inactive?
      !active?
    end
  end
end
