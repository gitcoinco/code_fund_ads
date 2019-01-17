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
#  company_name               :string
#  company_url                :string
#  company_logo_url           :string
#  title                      :string           not null
#  description                :text             not null
#  how_to_apply               :text
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
#  start_date                 :date             not null
#  end_date                   :date             not null
#  full_text_search           :tsvector
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class JobPosting < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  include Taggable
  include JobPostings::Presentable

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
  validates :source, inclusion: {in: ENUMS::JOB_SOURCES.keys}
  validates :source_identifier, presence: true, if: -> { external? }
  validates :start_date, presence: true
  validates :end_date, presence: true

  # callbacks .................................................................

  # scopes ....................................................................
  scope :internal, -> { where(source: ENUMS::JOB_SOURCES::INTERNAL) }
  scope :remoteok, -> { where(source: ENUMS::JOB_SOURCES::REMOTEOK) }
  scope :github, -> { where(source: ENUMS::JOB_SOURCES::GITHUB) }
  scope :search_company_name, ->(value) { value.blank? ? all : search_column(:company_name, value) }
  scope :search_country_codes, ->(*values) { values.blank? ? all : where(country_code: values) }
  scope :search_description, ->(value) { value.blank? ? all : search_column(:description, value) }
  scope :search_job_types, ->(*values) { values.blank? ? all : where(job_type: values) }
  scope :search_keywords, ->(*values) { values.blank? ? all : with_any_keywords(*values) }
  scope :search_organization, ->(value) { value.blank? ? all : where(organization_id: value) }
  scope :search_province_codes, ->(*values) { values.blank? ? all : where(province_code: values) }
  scope :search_remote, ->(value) { value.nil? ? all : where(remote: value) }
  scope :search_title, ->(value) { value.blank? ? all : search_column(:title, value) }

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
