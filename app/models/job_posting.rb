# == Schema Information
#
# Table name: job_postings
#
#  id                         :bigint           not null, primary key
#  auto_renew                 :boolean          default(TRUE), not null
#  city                       :string
#  company_email              :string
#  company_logo_url           :string
#  company_name               :string
#  company_url                :string
#  country_code               :string
#  description                :text             not null
#  detail_view_count          :integer          default(0), not null
#  display_salary             :boolean          default(TRUE)
#  end_date                   :date             not null
#  full_text_search           :tsvector
#  how_to_apply               :text
#  job_type                   :string           not null
#  keywords                   :string           default([]), not null, is an Array
#  list_view_count            :integer          default(0), not null
#  max_annual_salary_cents    :integer          default(0), not null
#  max_annual_salary_currency :string           default("USD"), not null
#  min_annual_salary_cents    :integer          default(0), not null
#  min_annual_salary_currency :string           default("USD"), not null
#  offers                     :string           default([]), not null, is an Array
#  plan                       :string
#  province_code              :string
#  province_name              :string
#  remote                     :boolean          default(FALSE), not null
#  remote_country_codes       :string           default([]), not null, is an Array
#  source                     :string           default("internal"), not null
#  source_identifier          :string
#  start_date                 :date             not null
#  status                     :string           default("pending"), not null
#  title                      :string           not null
#  url                        :text
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  campaign_id                :bigint
#  coupon_id                  :bigint
#  organization_id            :bigint
#  session_id                 :string
#  stripe_charge_id           :string
#  user_id                    :bigint
#
# Indexes
#
#  index_job_postings_on_auto_renew                    (auto_renew)
#  index_job_postings_on_campaign_id                   (campaign_id)
#  index_job_postings_on_city                          (city)
#  index_job_postings_on_company_name                  (company_name)
#  index_job_postings_on_country_code                  (country_code)
#  index_job_postings_on_coupon_id                     (coupon_id)
#  index_job_postings_on_detail_view_count             (detail_view_count)
#  index_job_postings_on_end_date                      (end_date)
#  index_job_postings_on_full_text_search              (full_text_search) USING gin
#  index_job_postings_on_job_type                      (job_type)
#  index_job_postings_on_keywords                      (keywords) USING gin
#  index_job_postings_on_list_view_count               (list_view_count)
#  index_job_postings_on_max_annual_salary_cents       (max_annual_salary_cents)
#  index_job_postings_on_min_annual_salary_cents       (min_annual_salary_cents)
#  index_job_postings_on_offers                        (offers) USING gin
#  index_job_postings_on_organization_id               (organization_id)
#  index_job_postings_on_plan                          (plan)
#  index_job_postings_on_province_code                 (province_code)
#  index_job_postings_on_province_name                 (province_name)
#  index_job_postings_on_remote                        (remote)
#  index_job_postings_on_remote_country_codes          (remote_country_codes) USING gin
#  index_job_postings_on_session_id                    (session_id)
#  index_job_postings_on_source_and_source_identifier  (source,source_identifier) UNIQUE
#  index_job_postings_on_start_date                    (start_date)
#  index_job_postings_on_title                         (title)
#  index_job_postings_on_user_id                       (user_id)
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
    def recent_sample(count)
      active
        .ranked_by_source
        .where.not(company_logo_url: "")
        .where.not(company_logo_url: nil)
        .where(arel_table[:start_date].gt(1.month.ago))
        .group(:id, :company_name)
        .sample(count + 18)
        .to_a
        .uniq { |job| job.company_name }
        .sample(count)
    end
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
    []
      .then { |result| remote? ? result << make_tsvector("remote", weight: "A") : result }
      .then { |result| keywords.blank? ? result : keywords.each_with_object(result) { |tag, memo| memo << make_tsvector(tag, weight: "A") } }
      .then { |result| job_type.blank? ? result : result << make_tsvector(job_type, weight: "B") }
      .then { |result| title.blank? ? result : result << make_tsvector(title, weight: "B") }
      .then { |result| company_name.blank? ? result : result << make_tsvector(company_name, weight: "B") }
      .then { |result| city.blank? ? result : result << make_tsvector(city, weight: "C") }
      .then { |result| province_name.blank? ? result : result << make_tsvector(province_name, weight: "C") }
      .then { |result| country_code.blank? ? result : result << make_tsvector(country_code, weight: "C") }
      .then { |result| Country.find(country_code).blank? ? result : result << make_tsvector(Country.find(country_code).name, weight: "C") }
      .then { |result| description.blank? ? result : result << make_tsvector(description, weight: "D") }
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
