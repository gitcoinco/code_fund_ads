class ProspectiveJobPosting
  include ActiveModel::Model

  # some examples of what/how to capture data
  # NOTE: only value types here (string, number, etc...)
  #       as instances are serialized to json & stored in the Redis session
  attr_accessor(
    :id,
    :organization_id,
    :organization_name,
    :company_name,
    :company_url,
    :company_logo_url, 
    :title,
    :description,
    :how_to_apply,
    :job_type,
    :url,
    :keywords,
    :min_annual_salary_cents,
    :min_annual_salary_currency,
    :max_annual_salary_cents,
    :max_annual_salary_currency,
    :remote,
    :city,
    :province_name,
    :province_code,
    :country_code,
    :start_date,
    :end_date,
  )

  class << self
    def find(id)
      json = Rails.cache.read(cache_key(id)) || {id: id}.to_json
      attributes = JSON.parse(json)
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
