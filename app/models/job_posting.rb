# == Schema Information
#
# Table name: job_postings
#
#  id                         :bigint(8)        not null, primary key
#  organization_id            :bigint(8)        not null
#  user_id                    :bigint(8)        not null
#  campaign_id                :bigint(8)
#  source                     :string           default("internal"), not null
#  source_identifier          :string
#  job_type                   :string           not null
#  title                      :string           not null
#  description                :text             not null
#  keywords                   :string           default([]), not null, is an Array
#  min_annual_salary_cents    :integer          default(0), not null
#  min_annual_salary_currency :string           default("USD"), not null
#  max_annual_salary_cents    :integer          default(0), not null
#  max_annual_salary_currency :string           default("USD"), not null
#  remote                     :boolean          default(FALSE), not null
#  city                       :string
#  province_name              :string
#  province_code              :string
#  country_code               :string
#  url                        :text
#  start_date                 :date
#  end_date                   :date
#  full_text_search           :tsvector
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class JobPosting < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  include Taggable

  # relationships .............................................................
  belongs_to :campaign, optional: true
  belongs_to :organization
  belongs_to :user

  # validations ...............................................................
  validates :title, length: {within: 2..80}
  validates :description, presence: true
  validates :job_type, inclusion: {in: ENUMS::JOB_TYPES.keys}
  validates :max_annual_salary_cents, presence: true
  validates :max_annual_salary_currency, presence: true
  validates :min_annual_salary_cents, presence: true
  validates :min_annual_salary_currency, presence: true
  validates :remote, presence: true
  validates :source, inclusion: {in: ENUMS::JOB_SOURCES.keys}
  validates :source_identifier, presence: true, if: -> { external? }
  validates :start_date, presence: true
  validates :end_date, presence: true

  # callbacks .................................................................

  # scopes ....................................................................
  scope :remoteok, -> { where(source: ENUMS::JOB_SOURCES::REMOTEOK) }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  tag_columns :keywords

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def external?
    source != ENUMS::JOB_SOURCES::INTERNAL
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
end
