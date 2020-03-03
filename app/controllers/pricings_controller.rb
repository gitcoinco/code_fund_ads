class PricingsController < ApplicationController
  def show
    @base = Money.new((params[:base] || ENV.fetch("BASE_ECPM", 400)).to_i, "USD")
    @multiplier = params[:multiplier]

    @regions = {}
    @countries = []
    Country.all.each do |country|
      @regions[country.region] ||= {}
      @regions[country.region][country.subregion] ||= {display_price: country.ecpm(base: @base, multiplier: @multiplier).format, countries: []}
      c = {
        id: country.id,
        region: country.region,
        subregion: country.subregion,
        name: country.name,
        value: country.ecpm(base: @base, multiplier: @multiplier).to_f,
        display_price: country.ecpm(base: @base, multiplier: @multiplier).format,
        emoji_flag: country.emoji_flag
      }
      @regions[country.region][country.subregion][:countries] << c
      @countries << c
    end
  end
end
