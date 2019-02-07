class Country
  include ActiveModel::Model
  attr_accessor :name, :iso_code

  class << self
    def data
      @data ||= begin
        Province.all.each_with_object({}) do |province, memo|
          memo[province.country_code] ||= {name: province.country_name, iso_code: province.country_code}
        end
      end
    end

    def find(id)
      return nil unless data[id.to_s]
      new data[id.to_s]
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

    def countries(base_ecpm = ENV.fetch("BASE_ECPM", 4).to_f)
      campaign = Campaign.new(ecpm: base_ecpm, fixed_ecpm: false, country_codes: ENUMS::COUNTRIES.keys)
      @countries ||= ISO3166::Country.all.each_with_object({}) { |country, memo|
        data = country.data
        memo[data["alpha2"]] = {
          id: data["alpha2"],
          value: campaign.adjusted_ecpm(data["alpha2"])&.to_f,
          name: data["name"],
          region: data["region"],
          subregion: data["subregion"],
          iso_code: data["alpha2"],
          emoji_flag: country.emoji_flag,
          price: campaign.adjusted_ecpm(data["alpha2"])&.to_f,
          display_price: campaign.adjusted_ecpm(data["alpha2"])&.format,
        }
      }
    end
  end

  alias id iso_code
end
