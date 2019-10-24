class PagesController < ApplicationController
  layout "home"

  def index
    @report_from_date = Date.parse("2019-01-01")
  end
end
