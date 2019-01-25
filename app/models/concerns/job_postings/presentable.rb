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

    def pretty_description
      pretty_body(description)
    end

    def pretty_how_to_apply
      pretty_body(how_to_apply)
    end

    def pretty_body(html)
      sanitize(simple_format(html), tags: %w[p strong em a ul li], attributes: %w[href])
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
  end
end
