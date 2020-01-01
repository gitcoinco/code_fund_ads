class JobPostingsController < ApplicationController
  before_action :authenticate_user!, if: -> { params[:manage_scope] }
  before_action :set_job_posting, except: [:index]
  before_action :set_job_posting_search, only: [:index, :show]

  def index
    if params[:manage_scope]
      job_postings = JobPosting.where(user: current_user).order(start_date: :desc)
    else
      job_postings = JobPosting.active.ranked_by_source.order(start_date: :desc)
      job_postings = @job_posting_search.apply(job_postings)
      if @job_posting_search.full_text_search
        job_postings = job_postings.or(
          JobPosting.active.ranked_by_source.order(start_date: :desc)
            .ranked(@job_posting_search.full_text_search)
            .search_company_name(@job_posting_search.full_text_search)
        )
      end
    end
    @premium_job_postings = job_postings.with_all_offers(ENUMS::JOB_OFFERS::PREMIUM_PLACEMENT)
    @job_postings_count = @premium_job_postings.reorder("").size + job_postings.reorder("").size
    @pagy, @job_postings = pagy(job_postings.without_all_offers(ENUMS::JOB_OFFERS::PREMIUM_PLACEMENT), items: 30)

    unless device.bot?
      @premium_job_postings.reorder("").pluck(:id).each { |id| IncrementJobPostingViewsJob.perform_later(id, "list_view_count") }
      @job_postings.reorder("").pluck(:id).each { |id| IncrementJobPostingViewsJob.perform_later(id, "list_view_count") }
    end

    if params[:partial]
      return render partial: "/job_postings/list_items", locals: {job_postings: @job_postings, pagy: @pagy}, layout: false
    end

    if params[:manage_scope]
      render "/job_postings/for_user/index"
    end
  end

  def show
    set_meta_tags @job_posting
    job_postings = JobPosting.active.order(start_date: :desc)
    job_postings = @job_posting_search.apply(job_postings)
    job_postings = job_postings.where.not(id: @job_posting.id)
    @similar_job_postings_count = job_postings.reorder("").size
    @similar_job_postings = job_postings.limit(12)
    @report_job_post_link = "mailto:team@codefund.io?#{{
      subject: "[Report Job] #{@job_posting.title}",
      body: "Link: #{job_posting_url(@job_posting)}\n\nI am reporting this job because ...\n\n",
    }.to_query}".gsub("+", "%20")
    IncrementJobPostingViewsJob.perform_later @job_posting.id, "detail_view_count" unless device.bot?
  end

  def edit
    return render_forbidden unless authorized_user.can_update_job_posting?(@job_posting, session.id)
  end

  def update
    return render_forbidden unless authorized_user.can_update_job_posting?(@job_posting, session.id)
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
    clear_searches except: :job_posting_search
    @job_posting_search = GlobalID.parse(session[:job_posting_search]).find if session[:job_posting_search].present?
    @job_posting_search ||= JobPostingSearch.new
  end

  def set_job_posting
    @job_posting = JobPosting.find_by(id: params[:id])
    render_not_found unless @job_posting
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
