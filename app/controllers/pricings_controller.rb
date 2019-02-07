class PricingsController < ApplicationController
  def show
    @ecpm = params[:ecpm]&.to_f || ENV.fetch("BASE_ECPM", 4).to_f
    @countries = Country.countries(@ecpm).values
  end
end
