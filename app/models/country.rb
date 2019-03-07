class Country
  UNKNOWN_CPM_MULTIPLER = 0.05

  include ActiveModel::Model
  attr_accessor(
    :region,
    :subregion,
    :name,
    :iso_code,
    :subregion_cpm_multiplier,
    :country_cpm_multiplier,
    :emoji_flag
  )

  class << self
    def data
      @data ||= begin
        Province.all.each_with_object({}) do |province, memo|
          memo[province.country_code] ||= {
            region: province.region,
            subregion: province.subregion,
            name: province.country_name,
            iso_code: province.country_code,
            subregion_cpm_multiplier: province.subregion_cpm_multiplier,
            country_cpm_multiplier: province.country_cpm_multiplier,
            emoji_flag: province.emoji_flag,
          }
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
  end

  alias id iso_code

  def ecpm(base: nil, multiplier: nil)
    base = Money.new(ENV.fetch("BASE_ECPM", 400).to_i, "USD") unless base.is_a?(Money)
    value = base * (subregion_cpm_multiplier || Country::UNKNOWN_CPM_MULTIPLER)
    value = base * (country_cpm_multiplier || Country::UNKNOWN_CPM_MULTIPLER) if multiplier.to_s == "country"
    value = Monetize.parse("$0.10 USD") if value.cents < 10
    value
  end
end
