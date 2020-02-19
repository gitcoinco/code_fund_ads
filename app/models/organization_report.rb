# == Schema Information
#
# Table name: organization_reports
#
#  id              :bigint           not null, primary key
#  campaign_ids    :bigint           default([]), not null, is an Array
#  end_date        :date             not null
#  pdf_url         :text
#  start_date      :date             not null
#  status          :string           default("pending"), not null
#  title           :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_organization_reports_on_organization_id  (organization_id)
#

class OrganizationReport < ApplicationRecord
  # extends ...................................................................

  # includes ..................................................................
  include Taggable

  # relationships .............................................................
  belongs_to :organization

  # validations ...............................................................
  validates :organization_id, presence: true
  validates :end_date, presence: true
  validates :start_date, presence: true
  validates :status, presence: true
  validates :title, presence: true

  # callbacks .................................................................
  # scopes ....................................................................

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  attr_accessor :date_range, :recipients
  tag_columns :campaign_ids
  has_one_attached :pdf

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def campaigns
    Campaign.where(id: campaign_ids).order(name: :asc)
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
end
