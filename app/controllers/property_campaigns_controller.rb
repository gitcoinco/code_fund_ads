class PropertyCampaignsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_property

  def index
    # TODO: we don't want to eager load this
    report = @property.daily_summary_reports_by_campaign(@start_date, @end_date).to_a
    @pagy, @report = pagy_array(report, items: Pagy::VARS[:items])
  end

  private

  def set_property
    @property = if authorized_user.can_admin_system?
      Property.find(params[:property_id])
    else
      current_user.properties.find(params[:property_id])
    end
  end
end
