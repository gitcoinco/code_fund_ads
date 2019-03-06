class PricingsController < ApplicationController
  def show
    @base = Money.new((params[:base] || ENV.fetch("BASE_ECPM", 400)).to_i, "USD")
    @multiplier = params[:multiplier]

    @countries = Country.all.map { |country|
      {
        id: country.id,
        region: country.region,
        subregion: country.subregion,
        name: country.name,
        value: country.ecpm(base: @base, multiplier: @multiplier).to_f,
        display_price: country.ecpm(base: @base, multiplier: @multiplier).format,
        emoji_flag: country.emoji_flag,
      }
    }

    @countries.sort_by! { |country| [country[:value] * -1, country[:name]] }
  end
end
