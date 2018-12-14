class ApplicantsController < ApplicationController
  include Sortable

  before_action :authenticate_administrator!

  def index
    applicants = Applicant.order(created_at: :asc)
    @pagy, @applicants = pagy(applicants)
  end

  def show
    @applicant = Applicant.find(params[:id])
  end

  private

  def sortable_columns
    %w[
      role
      first_name
      email
      status
      created_at
    ]
  end
end
