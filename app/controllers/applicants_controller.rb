class ApplicantsController < ApplicationController
  include Sortable

  before_action :authenticate_administrator!
  before_action :set_applicant, only: [:show, :update]

  def index
    applicants = Applicant.order(created_at: :asc)
    @pagy, @applicants = pagy(applicants)
  end

  def update
    respond_to do |format|
      if @applicant.update(applicant_params)
        format.html { redirect_to @applicant, notice: "Applicant was successfully updated." }
        format.json { render :show, status: :ok, location: @applicant }
      else
        format.html { redirect_to @applicant, error: "Unable to apply status to applicant" }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_applicant
    @applicant = Applicant.find(params[:id])
  end

  def applicant_params
    params.require(:applicant).permit(:status, :organization_id)
  end

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
