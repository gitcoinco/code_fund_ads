class JobPostingsController < ApplicationController
  before_action :authenticate_user!, if: -> { params[:manage_scope] }
  before_action :set_job_posting, except: [:index]
  before_action :set_job_posting_search, only: [:index, :show]

  def index
    job_postings = JobPosting.active.order(start_date: :desc)
    job_postings = if params[:manage_scope]
      job_postings.where(user: current_user)
    else
      @job_posting_search.apply(job_postings)
    end
    @job_postings_count = job_postings.reorder("").size
    @pagy, @job_postings = pagy(job_postings, items: 30)

    if params[:partial]
      return render partial: "/job_postings/list_items", locals: {job_postings: @job_postings, pagy: @pagy}, layout: false
    end

    if params[:manage_scope]
      return render "/job_postings/for_user/index"
    end
  end

  def show
    job_postings = JobPosting.active.order(start_date: :desc)
    job_postings = @job_posting_search.apply(job_postings)
    job_postings = job_postings.where.not(id: @job_posting.id)
    @similar_job_postings_count = job_postings.reorder("").size
    @similar_job_postings = job_postings.limit(12)
  end

  def edit
    return render_forbidden unless authorized_user.can_update_job_posting?(@job_posting, current_user.id)
  end

  def update
    return render_forbidden unless authorized_user.can_update_job_posting?(@job_posting, current_user.id)
    respond_to do |format|
      if @job_posting.update(job_posting_params)
        format.html { redirect_to job_posting_path(@job_posting), notice: "Job was successfully updated." }
        format.json { render :show, status: :ok, location: @job_posting }
      else
        format.html { render :edit }
        format.json { render json: @job_posting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    raise NotImplementedError
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
      :auto_renew,
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
      whitelisted[:keywords] = params[:job_posting][:keywords].reject(&:blank?) if params[:job_posting][:keywords].present?
      whitelisted[:remote_country_codes] = params[:job_posting][:remote_country_codes].reject(&:blank?) if params[:job_posting][:remote_country_codes].present?
      whitelisted[:province_name] = Province.find_by_iso_code(params[:job_posting][:province_code])&.name if params[:job_posting][:province_name].present?
    end
  end
end
