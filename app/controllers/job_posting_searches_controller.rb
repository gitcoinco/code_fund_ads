class JobPostingSearchesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    session[:job_posting_search] = JobPostingSearch.new(job_posting_search_params).to_gid_param
    redirect_to job_postings_path
  end

  def update
    if session[:job_posting_search].present?
      job_posting_search = GlobalID.parse(session[:job_posting_search]).find
      session[:job_posting_search] = JobPostingSearch.new(job_posting_search.to_h(params[:remove])).to_gid_param
    end
    redirect_to campaigns_path
  end

  def destroy
    session[:job_posting_search] = JobPostingSearch.new.to_gid_param
    redirect_to job_postings_path
  end

  private

  def job_posting_search_params
    params.require(:job_posting_search).permit(
      :company_name,
      :description,
      :full_text_search,
      :organization_id,
      :remote,
      :title,
      country_codes: [],
      province_codes: [],
      job_types: [],
      keywords: []
    )
  end
end
