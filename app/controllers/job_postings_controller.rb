class JobPostingsController < ApplicationController
  before_action :set_job_posting, except: [:index, :new, :create]
  before_action :set_job_posting_search, only: [:index, :show]

  def index
    job_postings = JobPosting.active.order(start_date: :desc)
    job_postings = @job_posting_search.apply(job_postings)
    @job_postings_count = job_postings.reorder("").size
    @pagy, @job_postings = pagy(job_postings, items: 30)

    if params[:partial]
      render partial: "/job_postings/list_items", locals: {job_postings: @job_postings, pagy: @pagy}, layout: false
    end
  end

  def show
    render :preview if @job_posting.pending?

    job_postings = JobPosting.active.order(start_date: :desc)
    job_postings = @job_posting_search.apply(job_postings)
    job_postings = job_postings.where.not(id: @job_posting.id)
    @similar_job_postings_count = job_postings.reorder("").size
    @similar_job_postings = job_postings.limit(12)
  end

  def new
    @job_posting = JobPosting.new(
      status: ENUMS::JOB_STATUSES::PENDING,
      max_annual_salary_cents: nil,
      min_annual_salary_cents: nil,
      min_annual_salary_currency: "USD",
      job_type: ENUMS::JOB_TYPES::FULL_TIME
    )
  end

  def edit
  end

  def create
    @job_posting = JobPosting.new(job_posting_params)
    @job_posting.status = ENUMS::JOB_STATUSES::PENDING
    @job_posting.start_date = Date.today
    @job_posting.end_date = 1.month.from_now

    respond_to do |format|
      if @job_posting.save
        format.html { redirect_to @job_posting, notice: "Job posting was successfully created." }
        format.json { render :show, status: :created, location: @job_posting }
      else
        format.html { render :new }
        format.json { render json: @job_posting.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @job_posting.update(job_posting_params)
        format.html { redirect_to @job_posting, notice: "Job posting was successfully updated." }
        format.json { render :show, status: :ok, location: @job_posting }
      else
        format.html { render :edit }
        format.json { render json: @job_posting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job_posting.destroy
    respond_to do |format|
      format.html { redirect_to job_postings_url, notice: "Job posting was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_job_posting_search
    @job_posting_search = GlobalID.parse(session[:job_posting_search]).find if session[:job_posting_search].present?
    @job_posting_search ||= JobPostingSearch.new
  end

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
      whitelisted[:source] = ENUMS::JOB_SOURCES::INTERNAL
      whitelisted[:keywords] = params[:job_posting][:keywords].reject(&:blank?)
      whitelisted[:remote_country_codes] = params[:job_posting][:remote_country_codes].reject(&:blank?)
      whitelisted[:province_name] = Province.find_by_iso_code(params[:job_posting][:province_code])&.name
    end
  end
end
