class JobPostingProspectsController < ApplicationController
  before_action :set_job_posting, except: [:new, :create]

  def new
    @job_posting = JobPosting.new(
      title: default_value(development: "Full Stack Developer"),
      url: default_value(development: "https://example.com/job"),
      description: default_value(development: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
      how_to_apply: default_value(development: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
      company_name: default_value(development: "Example Company"),
      company_url: default_value(development: "https://example.com"),
      company_email: default_value(development: "jobs@example.com"),
      company_logo_url: default_value(development: "https://cdn.filestackcontent.com/QqHSDKc5R2Wl7ycC6Q87"),
      country_code: default_value(development: "US"),
      province_code: default_value(development: "US-CA"),
      city: default_value(development: "San Francisco"),
      keywords: default_value(development: %w[Ruby JavaScript Database]),
      remote: default_value(development: ENUMS::JOB_TYPES::FULL_TIME),
      remote_country_codes: default_value(development: ["US", "CA", "GB"]),
      min_annual_salary_cents: default_value(development: 75_000),
      max_annual_salary_cents: default_value(development: 150_000),
      min_annual_salary_currency: default_value(production: "USD"),
      job_type: default_value(production: ENUMS::JOB_TYPES::FULL_TIME)
    )
  end

  def create
    @job_posting = JobPosting.new(job_posting_params)
    @job_posting.status = ENUMS::JOB_STATUSES::PENDING
    @job_posting.start_date = Date.today
    @job_posting.end_date = 1.month.from_now

    respond_to do |format|
      if @job_posting.save
        session[:job_posting_prospect_id] = @job_posting.id
        format.html { redirect_to job_posting_prospect_path(@job_posting), notice: "Job was successfully created." }
        format.json { render :show, status: :created, location: @job_posting }
      else
        format.html { render :new }
        format.json { render json: @job_posting.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    return render_forbidden unless authorized_user.can_update_job_posting?(@job_posting, session.id)
  end

  def update
    return render_forbidden unless authorized_user.can_update_job_posting?(@job_posting, session.id)
    respond_to do |format|
      if @job_posting.update(job_posting_params)
        session[:job_posting_prospect_id] ||= @job_posting.id
        format.html { redirect_to job_posting_prospect_path(@job_posting), notice: "Job was successfully updated." }
        format.json { render :show, status: :ok, location: @job_posting }
      else
        format.html { render :edit }
        format.json { render json: @job_posting.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_job_posting
    @job_posting = JobPosting.find(params[:id])
  end

  def job_posting_params
    params.require(:job_posting).permit(
      :company_name,
      :company_url,
      :company_email,
      :company_logo_url,
      :title,
      :description,
      :how_to_apply,
      :job_type,
      :url,
      :min_annual_salary_cents,
      :max_annual_salary_cents,
      :min_annual_salary_currency,
      :remote,
      :city,
      :province_code,
      :country_code,
      :display_salary
    ).tap do |whitelisted|
      whitelisted[:user_id] = current_user&.id
      whitelisted[:session_id] = session.id
      whitelisted[:source] = ENUMS::JOB_SOURCES::INTERNAL
      whitelisted[:keywords] = params[:job_posting][:keywords].reject(&:blank?)
      whitelisted[:remote_country_codes] = params[:job_posting][:remote_country_codes].reject(&:blank?)
      whitelisted[:province_name] = Province.find_by_iso_code(params[:job_posting][:province_code])&.name
    end
  end
end
