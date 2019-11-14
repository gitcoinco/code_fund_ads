module Organizationable
  extend ActiveSupport::Concern

  included do
    belongs_to :organization

    before_validation :set_organization, only: [:create]
  end

  def set_organization
    self.organization = Current.organization
  end
end
