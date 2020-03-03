# == Schema Information
#
# Table name: regions
#
#  id                                        :integer          primary key
#  name                                      :text
#  blockchain_ecpm_currency                  :text
#  blockchain_ecpm_cents                     :integer
#  css_and_design_ecpm_currency              :text
#  css_and_design_ecpm_cents                 :integer
#  dev_ops_ecpm_currency                     :text
#  dev_ops_ecpm_cents                        :integer
#  game_development_ecpm_currency            :text
#  game_development_ecpm_cents               :integer
#  javascript_and_frontend_ecpm_currency     :text
#  javascript_and_frontend_ecpm_cents        :integer
#  miscellaneous_ecpm_currency               :text
#  miscellaneous_ecpm_cents                  :integer
#  mobile_development_ecpm_currency          :text
#  mobile_development_ecpm_cents             :integer
#  web_development_and_backend_ecpm_currency :text
#  web_development_and_backend_ecpm_cents    :integer
#  country_codes                             :text             is an Array
#

class Region < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  include Taggable

  # relationships .............................................................
  has_many :campaigns
  has_many :campaign_bundles

  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  self.primary_key = :id
  tag_columns :country_codes

  monetize :blockchain_ecpm_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :css_and_design_ecpm_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :dev_ops_ecpm_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :game_development_ecpm_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :javascript_and_frontend_ecpm_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :miscellaneous_ecpm_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :mobile_development_ecpm_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :web_development_and_backend_ecpm_cents, numericality: {greater_than_or_equal_to: 0}

  # class methods .............................................................
  class << self
    def africa
      local_ephemeral_cache.fetch("#{name}##{__method__}") { find 1 }
    end

    def americas_central_southern
      local_ephemeral_cache.fetch("#{name}##{__method__}") { find 2 }
    end

    def americas_northern
      local_ephemeral_cache.fetch("#{name}##{__method__}") { find 3 }
    end

    def asia_central_and_south_eastern
      local_ephemeral_cache.fetch("#{name}##{__method__}") { find 4 }
    end

    def asia_eastern
      local_ephemeral_cache.fetch("#{name}##{__method__}") { find 5 }
    end

    def asia_southern_and_western
      local_ephemeral_cache.fetch("#{name}##{__method__}") { find 6 }
    end

    def australia_and_new_zealand
      local_ephemeral_cache.fetch("#{name}##{__method__}") { find 7 }
    end

    def europe
      local_ephemeral_cache.fetch("#{name}##{__method__}") { find 8 }
    end

    def europe_eastern
      local_ephemeral_cache.fetch("#{name}##{__method__}") { find 9 }
    end

    def other
      local_ephemeral_cache.fetch("#{name}##{__method__}") { find 10 }
    end

    def average_day_of_week_impressions_counts(*regions)
      country_counts = regions.map { |region| Country.average_day_of_week_impressions_counts(countries: region.countries) }
      country_counts.each_with_object({}) { |entry, memo|
        entry.each do |day_of_week, count|
          memo[day_of_week] ||= 0
          memo[day_of_week] += count
        end
      }
    end

    def average_daily_impressions_count(*regions)
      counts = average_day_of_week_impressions_counts(*regions)
      return 0 unless counts.size > 0
      (counts.values.sum / counts.size.to_f).floor
    end

    def average_daily_impressions_count_by_audience(*regions)
      counts = average_day_of_week_impressions_counts(*regions)
      return 0 unless counts.size > 0
      (counts.values.sum / counts.size.to_f).floor
    end
  end

  # public instance methods ...................................................

  def name
    return "#{super} (US and Canada only)" if id == 3
    super
  end

  def read_only?
    true
  end

  def ecpm(audience)
    public_send audience.ecpm_column_name.delete_suffix("_cents")
  end

  def countries
    @countries ||= Country.where(iso_code: country_codes)
  end

  def average_day_of_week_impressions_counts
    @average_day_of_week_impressions_counts ||= Region.average_day_of_week_impressions_counts(self)
  end

  def average_daily_impressions_count
    @average_daily_impressions_count ||= Region.average_daily_impressions_count(self)
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
end
