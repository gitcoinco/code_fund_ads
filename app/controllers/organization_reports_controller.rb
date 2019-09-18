class OrganizationReportsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_organization

  def index
    organization_reports = @organization.organization_reports.order(created_at: :desc)
    @pagy, @organization_reports = pagy(organization_reports)
  end

  def new
    @organization_report = @organization.organization_reports.build
  end

  def create
    @organization_report = @organization.organization_reports.build(organization_report_params)
    respond_to do |format|
      if @organization_report.save
        format.html { redirect_to organization_reports_path(@organization), notice: "Report was successfully requested." }
        format.json { render :ok, status: :created }
      else
        format.html { render :new }
        format.json { render json: @organization_report.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @report = @organization.organization_reports.find(params[:id])
    @summaries = {}
    @report.campaigns.each do |campaign|
      @summaries[campaign.id] = campaign.summary(@report.start_date, @report.end_date)
    end
    render layout: false
  end

  def update
    @organization_report = @organization.organization_reports.find(params[:id])
    GenerateOrganizationReportJob.perform_later(id: @organization_report.id, report_url: organization_report_url(@organization, @organization_report))
    redirect_to organization_reports_path(@organization), notice: "PDF generate has been re-triggered"
  end

  def destroy
    @organization_report = @organization.organization_reports.find(params[:id])
    @organization_report.destroy
    respond_to do |format|
      format.html { redirect_to organization_reports_path(@organization), notice: "Report was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def organization_report_params
    params.require(:organization_report).permit(
      :title,
      campaign_ids: [],
    ).tap do |whitelisted|
      dates = params[:organization_report][:date_range].split(" - ")
      whitelisted[:start_date] = Date.strptime(dates[0], "%m/%d/%Y")
      whitelisted[:end_date] = Date.strptime(dates[1], "%m/%d/%Y")
    end
  end
end
