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
  include Audiences::Presentable
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

    def inventory_summary(start_date = nil, end_date = nil)
      rows = all.map { |audience| audience.inventory_summary(start_date, end_date) }
      {
        impressions_count: rows.sum { |row| row[:impressions_count] },
        fallbacks_count: rows.sum { |row| row[:fallbacks_count] },
        sold_count: rows.sum { |row| row[:sold_count] },
        gross_revenue: rows.sum { |row| row[:gross_revenue] }.format,
        sold_value: rows.sum { |row| row[:sold_value] }.format,
        total_value: rows.sum { |row| row[:total_value] }.format,
        unrealized_sold_value: rows.sum { |row| row[:unrealized_sold_value] }.format,
        unrealized_total_value: rows.sum { |row| row[:unrealized_total_value] }.format,
      }
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

  def dailies(start_date = nil, end_date = nil, region: nil)
    daily_summaries(start_date, end_date, region: region)
      .select(:displayed_at_date)
      .select(DailySummary.arel_table[:impressions_count].sum.as("impressions_count"))
      .select(DailySummary.arel_table[:fallbacks_count].sum.as("fallbacks_count"))
      .select(DailySummary.arel_table[:clicks_count].sum.as("clicks_count"))
      .select(DailySummary.arel_table[:gross_revenue_cents].sum.as("gross_revenue_cents"))
      .group(:displayed_at_date)
      .order(:displayed_at_date)
  end

  def impressions_count(start_date = nil, end_date = nil, region: nil)
    daily_summaries(start_date, end_date, region: region).sum(:impressions_count)
  end

  def fallbacks_count(start_date = nil, end_date = nil, region: nil)
    daily_summaries(start_date, end_date, region: region).sum(:fallbacks_count)
  end

  def clicks_count(start_date = nil, end_date = nil, region: nil)
    daily_summaries(start_date, end_date, region: region).sum(:clicks_count)
  end

  def gross_revenue_cents(start_date = nil, end_date = nil, region: nil)
    daily_summaries(start_date, end_date, region: region).sum(:gross_revenue_cents)
  end

  def click_rate(start_date = nil, end_date = nil, region: nil)
    icount = impressions_count(start_date, end_date, region: region)
    ccount = clicks_count(start_date, end_date, region: region)
    icount.zero? ? 0 : (ccount / icount.to_f) * 100
  end

  def inventory(start_date = nil, end_date = nil)
    Region.all.each_with_object([]) do |region, memo|
      gross_revenue_cents = gross_revenue_cents(start_date, end_date, region: region)
      gross_revenue = Money.new(gross_revenue_cents, "USD")
      count = impressions_count(start_date, end_date, region: region)
      fallback_count = fallbacks_count(start_date, end_date, region: region)
      sold_count = count - fallback_count
      ecpm = ecpm_for_region(region)
      total_value = (count / 1000.to_f) * ecpm_for_region(region)
      sold_value = (sold_count / 1000.to_f) * ecpm_for_region(region)
      memo << {
        audience_name: name,
        region_name: region.name,
        impressions_count: count,
        fallbacks_count: fallback_count,
        sold_count: sold_count,
        gross_revenue: gross_revenue,
        ecpm: ecpm,
        sold_value: sold_value,
        total_value: total_value,
        unrealized_sold_value: (sold_value - gross_revenue),
        unrealized_total_value: (total_value - gross_revenue),
      }
    end
  end

  def inventory_summary(start_date = nil, end_date = nil)
    rows = inventory(start_date, end_date)
    impressions_count = rows.sum { |row| row[:impressions_count] }
    fallbacks_count = rows.sum { |row| row[:fallbacks_count] }
    sold_value = rows.sum { |row| row[:sold_value] }
    total_value = rows.sum { |row| row[:total_value] }
    gross_revenue = rows.sum { |row| row[:gross_revenue] }
    {
      audience_name: name,
      impressions_count: impressions_count,
      fallbacks_count: fallbacks_count,
      sold_count: impressions_count - fallbacks_count,
      gross_revenue: gross_revenue,
      sold_value: sold_value,
      total_value: total_value,
      unrealized_sold_value: (sold_value - gross_revenue),
      unrealized_total_value: (total_value - gross_revenue),
    }
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
end
