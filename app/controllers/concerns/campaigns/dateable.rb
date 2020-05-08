module Campaigns
  module Dateable
    extend ActiveSupport::Concern

    # Force dates used for reports to match the dates of the current campaign
    # Overrides the logic in: app/controllers/concerns/dateable.rb
    def set_dates_to_campaign
      @start_date = @campaign.start_date
      session[:start_date] = @start_date.to_s("mm/dd/yyyy")

      @end_date = @campaign.end_date
      session[:end_date] = @end_date.to_s("mm/dd/yyyy")
    end
  end
end
