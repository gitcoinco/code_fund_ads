class PricingsController < ApplicationController
  def show
    @ecpm = params[:ecpm].present? ? params[:ecpm].to_i : ENV.fetch("BASE_ECPM", 400).to_i
    @countries = Country.countries(@ecpm).values
  end
end
