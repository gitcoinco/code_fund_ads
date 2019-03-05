class Province
  include ActiveModel::Model
  attr_accessor(
    :region,
    :subregion,
    :country_name,
    :country_code,
    :province_name,
    :subdivision,
    :cpm_multiplier,
    :emoji_flag,
  )

  class << self
    def data
      @data ||= begin
        cpm_multipliers = YAML.safe_load(File.read(Rails.root.join("config/cpm_multipliers.yml")))

        ISO3166::Country.all.each_with_object({}) do |country, memo|
          if country.subdivisions?
            country.subdivisions.each do |code, subdivision|
              memo["#{country.alpha2}-#{code}"] = {
                region: country.region,
                subregion: country.subregion,
                country_code: country.alpha2,
                country_name: country.name,
                province_name: subdivision[:name],
                subdivision: code,
                cpm_multiplier: cpm_multipliers[country.subregion] || Country::UNKNOWN_CPM_MULTIPLER,
                emoji_flag: country.emoji_flag,
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
              cpm_multiplier: cpm_multipliers[country.subregion] || Country::UNKNOWN_CPM_MULTIPLER,
              emoji_flag: country.emoji_flag,
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
