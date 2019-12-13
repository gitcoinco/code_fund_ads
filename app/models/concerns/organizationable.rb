module Organizationable
  extend ActiveSupport::Concern

  included do
    belongs_to :organization

    before_validation :set_organization, on: :create
  end

  def set_organization
    self.organization_id ||= Current&.organization&.id
  end
end
