# == Schema Information
#
# Table name: audiences
#
#  id               :integer          primary key
#  name             :text
#  ecpm_column_name :text
#  keywords         :text             is an Array
#

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

  def daily_summaries(start_date = nil, end_date = nil, region: nil)
    summaries = DailySummary.between(start_date, end_date).where(impressionable_type: "Property", impressionable_id: properties.active.select(:id))
    summaries = case region
    when nil then summaries.scoped_by(nil)
    when Region.other then summaries.scoped_by(region.country_codes, "country_code").or(summaries.where(scoped_by_type: "country_code", scoped_by_id: nil))
    else summaries.scoped_by(region.country_codes, "country_code")
    end
    summaries
  end

  def daily_impressions_counts(start_date = nil, end_date = nil, region: nil)
    daily_summaries(start_date, end_date, region: region).group(:displayed_at_date).order(:displayed_at_date).sum(:impressions_count)
  end

  def daily_clicks_counts(start_date = nil, end_date = nil, region: nil)
    daily_summaries(start_date, end_date, region: region).group(:displayed_at_date).order(:displayed_at_date).sum(:clicks_count)
  end

  def impressions_count(start_date = nil, end_date = nil, region: nil)
    daily_summaries(start_date, end_date, region: region).sum(:impressions_count)
  end

  def clicks_count(start_date = nil, end_date = nil, region: nil)
    daily_summaries(start_date, end_date, region: region).sum(:clicks_count)
  end

  def click_rate(start_date = nil, end_date = nil, region: nil)
    icount = impressions_count(start_date, end_date, region: region)
    ccount = clicks_count(start_date, end_date, region: region)
    icount.zero? ? 0 : (ccount / icount.to_f) * 100
  end

  def gross_revenue_cents(start_date = nil, end_date = nil, region: nil)
    daily_summaries(start_date, end_date, region: region).sum(:gross_revenue_cents)
  end

  def inventory(start_date = nil, end_date = nil)
    Region.all.each_with_object([]) do |region, memo|
      gross_revenue_cents = gross_revenue_cents(start_date, end_date, region: region)
      gross_revenue = Money.new(gross_revenue_cents, "USD")
      icount = impressions_count(start_date, end_date, region: region)
      per_mille = icount / 1000.to_f
      ecpm = ecpm_for_region(region)
      value = per_mille * ecpm_for_region(region)
      memo << {
        audience_name: name,
        region_name: region.name,
        impressions_count: icount,
        ecpm: ecpm,
        value: value,
        gross_revenue: gross_revenue,
        unrealized_value: (value - gross_revenue),
      }
    end
  end

  def inventory_summary(start_date = nil, end_date = nil)
    rows = inventory(start_date, end_date)
    impressions_count = rows.sum { |row| row[:impressions_count] }
    value = rows.sum { |row| row[:value] }
    gross_revenue = rows.sum { |row| row[:gross_revenue] }
    {
      audience_name: name,
      impressions_count: impressions_count,
      value: value.format,
      gross_revenue: gross_revenue,
      unrealized_value: (value - gross_revenue),
    }
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
end
