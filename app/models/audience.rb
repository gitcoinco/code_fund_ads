# == Schema Information
#
# Table name: audiences
#
#  id               :integer          primary key
#  ecpm_column_name :text
#  keywords         :text             is an Array
#  name             :text
#

class Audience < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  include Taggable

  # relationships .............................................................
  has_many :campaigns
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
      local_ephemeral_cache.fetch("#{name}##{__method__}") { find 1 }
    end

    def css_and_design
      local_ephemeral_cache.fetch("#{name}##{__method__}") { find 2 }
    end

    def dev_ops
      local_ephemeral_cache.fetch("#{name}##{__method__}") { find 3 }
    end

    def game_development
      local_ephemeral_cache.fetch("#{name}##{__method__}") { find 4 }
    end

    def javascript_and_frontend
      local_ephemeral_cache.fetch("#{name}##{__method__}") { find 5 }
    end

    def miscellaneous
      local_ephemeral_cache.fetch("#{name}##{__method__}") { find 6 }
    end

    def mobile_development
      local_ephemeral_cache.fetch("#{name}##{__method__}") { find 7 }
    end

    def web_development_and_backend
      local_ephemeral_cache.fetch("#{name}##{__method__}") { find 8 }
    end

    def matches(keywords = [])
      all.map do |audience|
        matched_keywords = audience.keywords & keywords
        {
          audience: audience,
          matched_keywords: matched_keywords,
          ratio: keywords.size.zero? ? 0 : matched_keywords.size / keywords.size.to_f
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

  def single_impression_price_for_region(region)
    ecpm_for_region(region).to_f / 1000
  end

  def daily_summaries(start_date = nil, end_date = nil, region: nil)
    summaries = DailySummary.between(start_date, end_date).where(impressionable_type: "Property", impressionable_id: properties.active.select(:id))
    region ? summaries.scoped_by(region.country_codes, "country_code") : summaries.scoped_by(nil)
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

  def average_daily_impressions_counts(region: nil)
    list = dailies(3.months.ago.beginning_of_month, 1.month.ago.end_of_month, region: region).to_a
    (1..31).each_with_object({}) do |day, memo|
      rows = list.select { |daily| daily.displayed_at_date.day == day }
      average_impressions_count = (rows.map(&:impressions_count).sum / rows.size.to_f).round
      memo[day] = average_impressions_count
    end
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
end
