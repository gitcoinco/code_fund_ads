class ApplicantSearchesController < ApplicationController
  before_action :authenticate_user!

  def create
    session[:applicant_search] = ApplicantSearch.new(applicant_search_params).to_gid_param
    redirect_to applicants_path
  end

  def update
    if session[:applicant_search].present?
      applicant_search = GlobalID.parse(session[:applicant_search]).find if session[:applicant_search].present?
      session[:applicant_search] = ApplicantSearch.new(applicant_search.to_h(params[:remove])).to_gid_param
    end
    redirect_to applicants_path
  end

  def destroy
    session[:applicant_search] = ApplicantSearch.new.to_gid_param
    redirect_to applicants_path
  end

  private

  def applicant_search_params
    params.require(:applicant_search).permit(
      :first_name,
      :last_name,
      :email,
      roles: [],
      statuses: [],
    )
  end
end
