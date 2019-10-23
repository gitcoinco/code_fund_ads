class HomeController < ApplicationController
  layout "home"

  def index
    @report_from_date = Date.parse("2019-01-01")
    @butter = ButterCMS::Page.get('*', 'homepage').data.fields
    @curves = ButterCMS::Page.get('*', 'curves').data.fields
  end
end
