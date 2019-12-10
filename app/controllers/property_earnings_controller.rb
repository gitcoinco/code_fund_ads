class PropertyEarningsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_property

  def show
    @paid_report = @property.daily_summaries_by_day(@start_date, @end_date, paid: true)
    @unpaid_report = @property.daily_summaries_by_day(@start_date, @end_date, paid: false)
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
