class ProspectiveJobPosting
  include ActiveModel::Model
  include ActiveModel::Validations
  include JobPostings::Presentable

  # some examples of what/how to capture data
  # NOTE: only value types here (string, number, etc...)
  #       as instances are serialized to json & stored in the Redis session
  attr_accessor(
    :id,
    :company_name,
    :company_url,
    :company_logo, 
    :title,
    :description,
    :how_to_apply,
    :job_type,
    :url,
    :keywords,
    :min_annual_salary_cents,
    :max_annual_salary_cents,
    :currency,
    :remote,
    :remote_country_codes,
    :city,
    :province_name,
    :province_code,
    :country_code,
    :start_date,
    :end_date,
    :errors,
  )

  # validations .......
  validates_length_of :title, in: 2..80
  validates_presence_of :description
  validates_inclusion_of :job_type, in: ENUMS::JOB_TYPES.keys
  validates_presence_of :max_annual_salary_cents
  validates_presence_of :min_annual_salary_cents
  validates_presence_of :currency
  validates_presence_of :company_name
  validates_presence_of :company_url
  validates_presence_of :how_to_apply
  validates_presence_of :url
  validates_presence_of :keywords
  validates_presence_of :remote_country_codes, if: -> { remote == "1" }
  validates_presence_of :city
  # validates_presence_of :province_code
  validates_presence_of :country_code
  
  class << self
    def find(id)
      json = Rails.cache.read(cache_key(id)) || {id: id}.to_json
      attributes = JSON.parse(json)
      attributes.delete("validation_context")
      new attributes
    end

    def cache_key(id)
      "#{name.underscore}/#{id}"
    end
  end

  def initialize(attributes = {})
    super
    @id ||= SecureRandom.uuid
  end

  def persisted?
    Rails.cache.exist? cache_key
  end

  def save
    Rails.cache.write cache_key, to_json, expires_in: 1.day
  end

  def cache_key
    self.class.cache_key id
  end
end
