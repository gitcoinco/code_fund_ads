# == Schema Information
#
# Table name: job_postings
#
#  id                         :bigint(8)        not null, primary key
#  organization_id            :bigint(8)
#  user_id                    :bigint(8)
#  campaign_id                :bigint(8)
#  status                     :string           default("pending"), not null
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
#  display_salary             :boolean          default(TRUE)
#  min_annual_salary_cents    :integer          default(0), not null
#  min_annual_salary_currency :string           default("USD"), not null
#  max_annual_salary_cents    :integer          default(0), not null
#  max_annual_salary_currency :string           default("USD"), not null
#  remote                     :boolean          default(FALSE), not null
#  remote_country_codes       :string           default([]), not null, is an Array
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
#  company_email              :string
#

class JobPosting < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  include Taggable
  include FullTextSearchable
  include JobPostings::Presentable

  # relationships .............................................................
  belongs_to :campaign, optional: true
  belongs_to :organization, optional: true
  belongs_to :user, optional: true

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

  with_options if: :internal? do |job_posting|
    job_posting.validates :company_name, presence: true
    job_posting.validates :company_url, presence: true
    job_posting.validates :company_logo_url, presence: true
    job_posting.validates :city, presence: true
    job_posting.validates :province_name, presence: true
    job_posting.validates :province_code, presence: true
    job_posting.validates :country_code, presence: true
  end

  # callbacks .................................................................
  before_validation :set_currency

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
  tag_columns :remote_country_codes

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def internal?
    source == ENUMS::JOB_SOURCES::INTERNAL
  end

  def external?
    !internal?
  end

  def pending?
    status == ENUMS::JOB_STATUSES::PENDING
  end

  def to_tsvector
    [].
      then { |result| keywords.blank? ? result : keywords.each_with_object(result) { |tag, memo| memo << make_tsvector(tag, weight: "A") } }.
      then { |result| title.blank? ? result : result << make_tsvector(title, weight: "B") }.
      then { |result| description.blank? ? result : result << make_tsvector(description, weight: "B") }.
      then { |result| job_type.blank? ? result : result << make_tsvector(job_type, weight: "C") }.
      then { |result| province_name.blank? ? result : result << make_tsvector(province_name, weight: "D") }.
      then { |result| country_code.blank? ? result : result << make_tsvector(country_code, weight: "D") }.
      then { |result| Country.find(country_code).blank? ? result : result << make_tsvector(Country.find(country_code).name, weight: "D") }.
      then { |result| result.compact.join " || " }
  end

  # protected instance methods ................................................

  # private instance methods ..................................................

  private

  def set_currency
    if min_annual_salary_currency.present?
      self.max_annual_salary_currency = min_annual_salary_currency
    end
  end
end
