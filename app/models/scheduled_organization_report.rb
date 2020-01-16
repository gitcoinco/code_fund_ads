# == Schema Information
#
# Table name: scheduled_organization_reports
#
#  id              :bigint           not null, primary key
#  campaign_ids    :bigint           default([]), not null, is an Array
#  dataset         :string           not null
#  end_date        :date             not null
#  frequency       :string           not null
#  recipients      :string           default([]), not null, is an Array
#  start_date      :date             not null
#  subject         :text             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_scheduled_organization_reports_on_organization_id  (organization_id)
#

class ScheduledOrganizationReport < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :organization

  # validations ...............................................................
  validates :campaign_ids, presence: true
  validates :subject, presence: true
  validates :dataset, inclusion: {in: ENUMS::SCHEDULED_ORGANIZATION_REPORT_DATASETS.values}
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :frequency, inclusion: {in: ENUMS::SCHEDULED_ORGANIZATION_REPORT_FREQUENCIES.values}
  validates :recipients, presence: true

  # callbacks .................................................................
  # scopes ....................................................................

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  attr_accessor :date_range

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def expired?
    end_date < Date.today
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
end
