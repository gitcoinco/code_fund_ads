module Campaigns
  module Dateable
    extend ActiveSupport::Concern

    # Force dates used for reports to match the dates of the current campaign
    # unless the date_range param is passed (aka the date picker is used)
    # Overrides the logic in: app/controllers/concerns/dateable.rb
    def set_dates_to_campaign
      if params[:date_range].present?
        dates = params[:date_range].split(" - ")
        @start_date = Date.strptime(dates[0], "%m/%d/%Y")
        @end_date = Date.strptime(dates[1], "%m/%d/%Y")
      else
        @start_date = @campaign.start_date
        @end_date = @campaign.end_date
      end

      session[:start_date] = @start_date.to_s("mm/dd/yyyy")
      session[:end_date] = @end_date.to_s("mm/dd/yyyy")
    end
  end
end
