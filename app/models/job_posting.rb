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
#  remote_country_codes       :string           default([]), is an Array
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

  # callbacks .................................................................
  before_validation :set_currency

  # scopes ....................................................................
  scope :internal, -> { where(source: ENUMS::JOB_SOURCES::INTERNAL) }
  scope :remoteok, -> { where(source: ENUMS::JOB_SOURCES::REMOTEOK) }
  scope :github, -> { where(source: ENUMS::JOB_SOURCES::GITHUB) }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  tag_columns :keywords
  tag_columns :remote_country_codes
  attr_accessor :currency

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def external?
    source != ENUMS::JOB_SOURCES::INTERNAL
  end

  # protected instance methods ................................................

  # private instance methods ..................................................

  private
  
  def set_currency
    if currency.present?
      self.min_annual_salary_currency = currency
      self.max_annual_salary_currency = currency
    end
  end
end
