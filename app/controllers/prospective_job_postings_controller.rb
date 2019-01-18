class ProspectiveJobPostingsController < ApplicationController
  before_action :set_prospective_job_posting, only: [:show, :edit, :update, :destroy]

  # GET /prospective_job_postings
  # GET /prospective_job_postings.json
  def index
    @prospective_job_postings = ProspectiveJobPosting.all
  end

  # GET /prospective_job_postings/1
  # GET /prospective_job_postings/1.json
  def show
  end

  # GET /prospective_job_postings/new
  def new
    @prospective_job_posting = ProspectiveJobPosting.new
  end

  # GET /prospective_job_postings/1/edit
  def edit
  end

  # POST /prospective_job_postings
  # POST /prospective_job_postings.json
  def create
    @prospective_job_posting = ProspectiveJobPosting.new(prospective_job_posting_params)

    respond_to do |format|
      if @prospective_job_posting.save
        format.html { redirect_to @prospective_job_posting, notice: "Prospective job posting was successfully created." }
        format.json { render :show, status: :created, location: @prospective_job_posting }
      else
        format.html { render :new }
        format.json { render json: @prospective_job_posting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prospective_job_postings/1
  # PATCH/PUT /prospective_job_postings/1.json
  def update
    respond_to do |format|
      if @prospective_job_posting.update(prospective_job_posting_params)
        format.html { redirect_to @prospective_job_posting, notice: "Prospective job posting was successfully updated." }
        format.json { render :show, status: :ok, location: @prospective_job_posting }
      else
        format.html { render :edit }
        format.json { render json: @prospective_job_posting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prospective_job_postings/1
  # DELETE /prospective_job_postings/1.json
  def destroy
    @prospective_job_posting.destroy
    respond_to do |format|
      format.html { redirect_to prospective_job_postings_url, notice: "Prospective job posting was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_prospective_job_posting
    @prospective_job_posting = ProspectiveJobPosting.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def prospective_job_posting_params
    params.fetch(:prospective_job_posting, {})
  end
end
