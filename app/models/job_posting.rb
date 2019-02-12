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
#  stripe_charge_id           :string
#  session_id                 :string
#  auto_renew                 :boolean          default(TRUE), not null
#  list_view_count            :integer          default(0), not null
#  detail_view_count          :integer          default(0), not null
#  coupon_id                  :bigint(8)
#  plan                       :string
#  offers                     :string           default([]), not null, is an Array
#

class JobPosting < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  include Sanitizable
  include Taggable
  include FullTextSearchable
  include JobPostings::Presentable
  include ActionView::Helpers::TextHelper

  # relationships .............................................................
  belongs_to :campaign, optional: true
  belongs_to :organization, optional: true
  belongs_to :user, optional: true
  belongs_to :coupon, optional: true

  # validations ...............................................................
  validates :title, length: {within: 2..130}
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
  before_validation :sanitize_plan
  before_validation :sanitize_offers

  # scopes ....................................................................
  scope :active, -> { where status: ENUMS::JOB_STATUSES::ACTIVE }
  scope :internal, -> { where source: ENUMS::JOB_SOURCES::INTERNAL }
  scope :remoteok, -> { where source: ENUMS::JOB_SOURCES::REMOTEOK }
  scope :github, -> { where source: ENUMS::JOB_SOURCES::GITHUB }
  scope :search_company_name, ->(value) { value.blank? ? all : search_column(:company_name, value) }
  scope :search_country_codes, ->(*values) { values.blank? ? all : where(country_code: values) }
  scope :search_description, ->(value) { value.blank? ? all : search_column(:description, value) }
  scope :search_job_types, ->(*values) { values.blank? ? all : where(job_type: values) }
  scope :search_keywords, ->(*values) { values.blank? ? all : with_any_keywords(*values) }
  scope :search_organization, ->(value) { value.blank? ? all : where(organization_id: value) }
  scope :search_province_codes, ->(*values) { values.blank? ? all : where(province_code: values) }
  scope :search_remote, ->(value) { value.nil? ? all : where(remote: value) }
  scope :search_title, ->(value) { value.blank? ? all : search_column(:title, value) }
  scope :similar_to, ->(job_posting) { search_keywords(job_posting.keywords).search_remote(job_posting.remote) }
  scope :ranked_by_source, -> {
    order Arel::Nodes::Case.new.when(arel_table[:source].eq(ENUMS::JOB_SOURCES::INTERNAL), 1).else(2)
  }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  tag_columns :keywords
  tag_columns :remote_country_codes
  tag_columns :offers
  sanitize :title, :description, :how_to_apply
  monetize :min_annual_salary_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :max_annual_salary_cents, numericality: {greater_than_or_equal_to: 0}

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def paid?
    stripe_charge_id.present?
  end

  def internal?
    source == ENUMS::JOB_SOURCES::INTERNAL
  end

  def external?
    !internal?
  end

  def pending?
    status == ENUMS::JOB_STATUSES::PENDING
  end

  def active?
    status == ENUMS::JOB_STATUSES::ACTIVE
  end

  def recent?
    start_date >= Date.current - 5.days
  end

  def premium_placement?
    has_offer? ENUMS::JOB_OFFERS::PREMIUM_PLACEMENT
  end

  def code_fund_ads?
    has_offer? ENUMS::JOB_OFFERS::CODE_FUND_ADS
  end

  def read_the_docs_ads?
    has_offer? ENUMS::JOB_OFFERS::READ_THE_DOCS_ADS
  end

  def province
    Province.find_by_iso_code(province_code)
  end

  def to_meta_tags
    {
      title: "#{company_name} is hiring: #{title}",
      keywords: ["Jobs"] + keywords,
      description: "Job Description: #{meta_description}",
      image_src: company_logo_url,
    }
  end

  def to_tsvectors
    [].
      then { |result| remote? ? result << make_tsvector("remote", weight: "A") : result }.
      then { |result| keywords.blank? ? result : keywords.each_with_object(result) { |tag, memo| memo << make_tsvector(tag, weight: "A") } }.
      then { |result| job_type.blank? ? result : result << make_tsvector(job_type, weight: "B") }.
      then { |result| title.blank? ? result : result << make_tsvector(title, weight: "B") }.
      then { |result| company_name.blank? ? result : result << make_tsvector(company_name, weight: "B") }.
      then { |result| city.blank? ? result : result << make_tsvector(city, weight: "C") }.
      then { |result| province_name.blank? ? result : result << make_tsvector(province_name, weight: "C") }.
      then { |result| country_code.blank? ? result : result << make_tsvector(country_code, weight: "C") }.
      then { |result| Country.find(country_code).blank? ? result : result << make_tsvector(Country.find(country_code).name, weight: "C") }.
      then { |result| description.blank? ? result : result << make_tsvector(description, weight: "D") }
  end

  def buffer_new_job_posting
    return unless ENV["BUFFER_ENABLED"] == "true"
    return unless source == ENUMS::JOB_SOURCES::INTERNAL
    return unless status == ENUMS::JOB_STATUSES::ACTIVE
    return unless status_previously_changed?
    return unless status_previous_change.first == ENUMS::JOB_STATUSES::PENDING
    return unless status_previous_change.last == ENUMS::JOB_STATUSES::ACTIVE
    BufferNewJobPostingJob.perform_later self, "/job_postings/tweets/new.text"
  end

  # protected instance methods ................................................

  # private instance methods ..................................................

  private

  def set_currency
    if min_annual_salary_currency.present?
      self.max_annual_salary_currency = min_annual_salary_currency
    end
  end

  def meta_description
    truncate(ActionView::Base.full_sanitizer.sanitize(description), length: 290)
  end

  def sanitize_plan
    self.plan = nil unless ENUMS::JOB_PLANS[plan]
  end

  def sanitize_offers
    self.offers = offers & ENUMS::JOB_OFFERS.keys
  end
end
