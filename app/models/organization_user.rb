# == Schema Information
#
# Table name: organization_users
#
#  id              :bigint           not null, primary key
#  role            :string           default("member"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_organization_users_on_organization_id  (organization_id)
#  index_organization_users_on_uniqueness       (organization_id,user_id,role) UNIQUE
#  index_organization_users_on_user_id          (user_id)
#

class OrganizationUser < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :organization
  belongs_to :user

  # validations ...............................................................
  validates :organization_id, uniqueness: {scope: [:user_id, :role]}
  validates :user_id, uniqueness: {scope: :organization_id}
  validates :role, inclusion: {in: ENUMS::ORGANIZATION_ROLES.values}

  # callbacks .................................................................
  # scopes ....................................................................

  scope :administrators, -> { where role: ENUMS::ORGANIZATION_ROLES::ADMINISTRATOR }
  scope :members, -> { where role: ENUMS::ORGANIZATION_ROLES::MEMBER }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def administrator?
    role == ENUMS::ORGANIZATION_ROLES::ADMINISTRATOR
  end

  def member?
    role == ENUMS::ORGANIZATION_ROLES::MEMBER
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
end
