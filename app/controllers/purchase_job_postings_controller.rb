class PurchaseJobPostingsController < ApplicationController
  before_action :authenticate_administrator!
  before_action :load_job_posting
  
  def new
  end

  private

  def load_job_posting
    @job_posting = JobPosting.find(params[:id])
  end
end
