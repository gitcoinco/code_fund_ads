class Province
  include ActiveModel::Model
  attr_accessor :country_name, :country_code, :province_name, :subdivision

  class << self
    def data
      @data ||= begin
        rows = JSON.parse(File.read(Rails.root.join("db/provinces.json")))
        rows.each_with_object({}) do |row, memo|
          memo["#{row["country_code"]}-#{row["subdivision"]}"] = row
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
