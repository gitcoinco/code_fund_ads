class ScheduledOrganizationReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization

  def create
    @report = @organization.scheduled_organization_reports.build(scheduled_organization_report_params)
    respond_to do |format|
      if @report.save
        ScheduleOrganizationReportJob.perform_later(id: @report.id)
        format.html { redirect_to organization_reports_path(@organization), notice: "Report was successfully scheduled." }
        format.json { render :ok, status: :created }
      else
        format.html { redirect_to organization_reports_path(@organization), alert: "Unable to generate scheduled report!" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @report = @organization.scheduled_organization_reports.find(params[:id])
    @report.destroy
    respond_to do |format|
      format.html { redirect_to organization_reports_path(@organization), notice: "Schedule was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_organization
    @organization = Current.organization
  end

  def scheduled_organization_report_params
    params.require(:scheduled_organization_report).permit(
      :date_range,
      :recipients,
      :subject,
      :frequency,
      :dataset,
      campaign_ids: [],
    ).tap do |whitelisted|
      dates = params[:scheduled_organization_report][:date_range].split(" - ")
      whitelisted[:start_date] = Date.strptime(dates[0], "%m/%d/%Y")
      whitelisted[:end_date] = Date.strptime(dates[1], "%m/%d/%Y")
      whitelisted[:recipients] = params[:scheduled_organization_report][:recipients].split(/\r\n+/).compact
    end
  end
end
