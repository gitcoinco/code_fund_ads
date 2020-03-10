require "csv"

class WordpressSnippetsController < ApplicationController
  def show
    return render_property_table if params[:id] == "property_table"
    return render_pricing_table if params[:id] == "pricing_table"
    render_not_found
  end

  private

  def render_property_table
    @properties = Property.active
    render partial: "/wordpress_snippets/property_table", layout: false
  end

  def render_pricing_table
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

    respond_to do |format|
      format.html { render partial: "/wordpress_snippets/pricing_table", layout: false }
      format.csv do
        column_names = @countries.first.keys
        results = CSV.generate { |csv|
          csv << column_names
          @countries.each do |x|
            csv << x.values
          end
        }
        send_data results, filename: "pricing-#{Date.today}.csv"
      end
    end
  end
end
