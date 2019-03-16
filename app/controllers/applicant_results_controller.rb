class ApplicantResultsController < ApplicationController
  before_action :authenticate_administrator!
  before_action :set_applicant

  private

  def set_applicant
    @applicant = Applicant.find(params[:applicant_id])
  end
end
