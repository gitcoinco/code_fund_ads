class DistributionsController < ApplicationController
  before_action :set_distribution, only: [:show, :edit, :update, :destroy]

  # GET /distributions
  # GET /distributions.json
  def index
    @distributions = Distribution.all
  end

  # GET /distributions/1
  # GET /distributions/1.json
  def show
  end

  # GET /distributions/new
  def new
    @distribution = Distribution.new
  end

  # GET /distributions/1/edit
  def edit
  end

  # POST /distributions
  # POST /distributions.json
  def create
    @distribution = Distribution.new(distribution_params)

    respond_to do |format|
      if @distribution.save
        format.html { redirect_to @distribution, notice: 'Distribution was successfully created.' }
        format.json { render :show, status: :created, location: @distribution }
      else
        format.html { render :new }
        format.json { render json: @distribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /distributions/1
  # PATCH/PUT /distributions/1.json
  def update
    respond_to do |format|
      if @distribution.update(distribution_params)
        format.html { redirect_to @distribution, notice: 'Distribution was successfully updated.' }
        format.json { render :show, status: :ok, location: @distribution }
      else
        format.html { render :edit }
        format.json { render json: @distribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /distributions/1
  # DELETE /distributions/1.json
  def destroy
    @distribution.destroy
    respond_to do |format|
      format.html { redirect_to distributions_url, notice: 'Distribution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_distribution
      @distribution = Distribution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def distribution_params
      params.fetch(:distribution, {})
    end
end
