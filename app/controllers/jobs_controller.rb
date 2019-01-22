class JobsController < ApplicationController
  before_action :set_job_posting_search

  private

  def set_job_posting_search
    @job_posting_search ||= JobPostingSearch.new
  end
end
