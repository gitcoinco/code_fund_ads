class PricingsController < ApplicationController
  def show
    @ecpm = Money.new((params[:ecpm] || ENV.fetch("BASE_ECPM", 400)).to_i, "USD")
    @countries = Country.all.map { |country|
      {id: country.id, value: country.ecpm.to_f, display_price: country.ecpm.format, emoji_flag: country.emoji_flag}
    }
    subregions = Country.all.each_with_object({}) { |country, memo|
      memo[country.subregion] ||= []
      memo[country.subregion] << country
    }
    @subregions = subregions.sort_by { |(name, countries)| countries.first.cpm_multiplier }.reverse
  end
end
