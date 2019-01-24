class JobPostingSearch < ApplicationSearchRecord
  FIELDS = %w[
    company_name
    country_codes
    description
    full_text_search
    job_types
    keywords
    organization_id
    province_codes
    remote
    title
  ].freeze

  def initialize(attrs = {})
    super FIELDS, attrs
    self.full_text_search = full_text_search.to_s.downcase.split(" ").uniq.join(" ")
    (self.country_codes ||= []).reject!(&:blank?)
    (self.job_types ||= []).reject!(&:blank?)
    (self.keywords ||= []).reject!(&:blank?)
    (self.province_codes ||= []).reject!(&:blank?)
  end

  def apply(relation)
    return relation unless present?

    relation.
      then { |result| result.matched_and_ranked(full_text_search) }.
      then { |result| result.search_company_name(company_name) }.
      then { |result| result.search_country_codes(*country_codes) }.
      then { |result| result.search_description(description) }.
      then { |result| result.search_job_types(*job_types) }.
      then { |result| result.search_keywords(*keywords) }.
      then { |result| result.search_organization(organization_id) }.
      then { |result| result.search_province_codes(*province_codes) }.
      then { |result| result.search_remote(remote) }.
      then { |result| result.search_title(title) }
  end
end
