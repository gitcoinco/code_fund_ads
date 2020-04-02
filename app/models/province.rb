class Province
  include ActiveModel::Model
  attr_accessor(
    :region,
    :subregion,
    :country_name,
    :country_code,
    :province_name,
    :subdivision,
    :subregion_cpm_multiplier,
    :country_cpm_multiplier,
    :emoji_flag
  )

  class << self
    def data
      @data ||= begin
        # TODO: update the multiplier strategy after all campaigns with a start_date before 2019-03-07 have completed
        subregion_cpm_multipliers = YAML.safe_load(File.read(Rails.root.join("config/subregion_cpm_multipliers.yml")))
        country_cpm_multipliers = YAML.safe_load(File.read(Rails.root.join("config/country_cpm_multipliers.yml")))

        ISO3166::Country.all.each_with_object({}) do |country, memo|
          next if %w[AQ BV TF HM].include? country.alpha2
          if country.subdivisions?
            country.subdivisions.each do |code, subdivision|
              memo["#{country.alpha2}-#{code}"] = {
                region: country.region,
                subregion: country.subregion,
                country_code: country.alpha2,
                country_name: country.name,
                province_name: subdivision[:name],
                subdivision: code,
                subregion_cpm_multiplier: subregion_cpm_multipliers[country.subregion] || Country::UNKNOWN_CPM_MULTIPLER,
                country_cpm_multiplier: country_cpm_multipliers[country.alpha2] || Country::UNKNOWN_CPM_MULTIPLER,
                emoji_flag: country.emoji_flag
              }
            end
          else
            memo[country.alpha2] = {
              region: country.region,
              subregion: country.subregion,
              country_code: country.alpha2,
              country_name: country.name,
              province_name: nil,
              subdivision: nil,
              subregion_cpm_multiplier: subregion_cpm_multipliers[country.subregion] || Country::UNKNOWN_CPM_MULTIPLER,
              country_cpm_multiplier: country_cpm_multipliers[country.alpha2] || Country::UNKNOWN_CPM_MULTIPLER,
              emoji_flag: country.emoji_flag
            }
          end
        end
      end
    end

    def find(id)
      return nil unless data[id.to_s]
      new data[id.to_s]
    end

    def find_by_iso_code(val)
      return nil unless val.present?

      country_code, subdivision = val.split("-")
      where(country_code: country_code, subdivision: subdivision).first
    end

    def all
      @all ||= data.values.map { |row| new row }
    end

    def where(attributes = {})
      all.select do |record|
        attributes.keys.map { |key|
          next unless record.respond_to?(key)
          expected_value = attributes[key]
          expected_value = [expected_value] unless expected_value.is_a?(Array)
          expected_value.include? record.send(key)
        }.uniq == [true]
      end
    end
  end

  def iso_code
    "#{country_code}-#{subdivision}"
  end

  alias id iso_code
  alias name province_name

  def full_name
    "#{name}, #{country_code}"
  end

  def country
    Country.find country_code
  end

  def persisted?
    true
  end

  def readonly?
    true
  end
end
