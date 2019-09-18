# == Schema Information
#
# Table name: organization_reports
#
#  id              :bigint           not null, primary key
#  organization_id :bigint           not null
#  title           :string           not null
#  status          :string           default("pending"), not null
#  start_date      :date             not null
#  end_date        :date             not null
#  campaign_ids    :text             default([]), is an Array
#  pdf_url         :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
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
  attr_accessor :date_range
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
