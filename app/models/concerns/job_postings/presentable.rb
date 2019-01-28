module JobPostings
  module Presentable
    extend ActiveSupport::Concern
    include ActionView::Helpers::NumberHelper
    include ActionView::Helpers::SanitizeHelper
    include ActionView::Helpers::TextHelper

    def company_host_url
      return "" unless company_url.present?
      URI.parse(company_url).host
    end

    def salary_range
      return "" unless min_annual_salary_cents && max_annual_salary_cents
      min = number_to_human min_annual_salary_cents, units: {thousand: "K"}
      max = number_to_human max_annual_salary_cents, units: {thousand: "K"}
      "#{min} - #{max}"
    end

    def company_location
      return city unless province&.name.present?
      return city unless country_code.present?

      "#{city}, #{province&.name}, #{country_code}"
    end

    def sanitized_description
      sanitize_value description
    end

    def sanitized_how_to_apply
      sanitize_value how_to_apply
    end
  end
end
