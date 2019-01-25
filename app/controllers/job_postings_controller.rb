class JobPostingsController < ApplicationController
  before_action :set_job_posting, except: [:index]
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
    job_postings = JobPosting.active.order(start_date: :desc)
    job_postings = @job_posting_search.apply(job_postings)
    job_postings = job_postings.where.not(id: @job_posting.id)
    @similar_job_postings_count = job_postings.reorder("").size
    @similar_job_postings = job_postings.limit(12)
  end

  def edit
    raise NotImplementedError
  end

  def update
    raise NotImplementedError
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
end
