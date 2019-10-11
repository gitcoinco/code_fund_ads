class Audience < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  include Taggable

  # relationships .............................................................
  has_many :properties

  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  self.primary_key = :id
  tag_columns :keywords

  # class methods .............................................................
  class << self
    def blockchain
      find 1
    end

    def css_and_design
      find 2
    end

    def dev_ops
      find 3
    end

    def game_development
      find 4
    end

    def javascript_and_frontend
      find 5
    end

    def miscellaneous
      find 6
    end

    def mobile_development
      find 7
    end

    def web_development_and_backend
      find 8
    end

    def matches(keywords = [])
      all.map do |audience|
        matched_keywords = audience.keywords & keywords
        {
          audience: audience,
          matched_keywords: matched_keywords,
          ratio: keywords.size.zero? ? 0 : matched_keywords.size / keywords.size.to_f,
        }
      end
    end

    def match(keywords = [])
      all_matches = matches(keywords)
      max = all_matches.max_by { |match| match[:ratio] }
      max_matches = all_matches.select { |match| match[:ratio] == max[:ratio] }
      if max_matches.size > 1
        preferred = max_matches.find { |match| match[:audience] == web_development_and_backend } if max_matches.include?(web_development_and_backend)
        preferred = max_matches.find { |match| match[:audience] == javascript_and_frontend } if max_matches.include?(javascript_and_frontend)
        max = preferred if preferred
      end
      max = all_matches.find { |match| match[:audience] == miscellaneous } if max[:ratio].zero?
      max[:audience]
    end
  end

  # public instance methods ...................................................

  def read_only?
    true
  end

  def ecpm_for_region(region)
    region ||= Region.find(3)
    region.public_send ecpm_column_name.delete_suffix("_cents")
  end

  def ecpm_for_country(country)
    ecpm_for_region Region.with_all_country_codes(country&.iso_code).first
  end

  def ecpm_for_country_code(country_code)
    ecpm_for_country Country.find(country_code)
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
end
