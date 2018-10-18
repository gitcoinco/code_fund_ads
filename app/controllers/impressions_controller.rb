class ImpressionsController < ApplicationController
  before_action :set_impression, only: [:show, :edit, :update, :destroy]

  # GET /impressions
  # GET /impressions.json
  def index
    @impressions = Impression.all
  end

  # GET /impressions/1
  # GET /impressions/1.json
  def show
  end

  # GET /impressions/new
  def new
    @impression = Impression.new
  end

  # GET /impressions/1/edit
  def edit
  end

  # POST /impressions
  # POST /impressions.json
  def create
    @impression = Impression.new(impression_params)

    respond_to do |format|
      if @impression.save
        format.html { redirect_to @impression, notice: 'Impression was successfully created.' }
        format.json { render :show, status: :created, location: @impression }
      else
        format.html { render :new }
        format.json { render json: @impression.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /impressions/1
  # PATCH/PUT /impressions/1.json
  def update
    respond_to do |format|
      if @impression.update(impression_params)
        format.html { redirect_to @impression, notice: 'Impression was successfully updated.' }
        format.json { render :show, status: :ok, location: @impression }
      else
        format.html { render :edit }
        format.json { render json: @impression.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /impressions/1
  # DELETE /impressions/1.json
  def destroy
    @impression.destroy
    respond_to do |format|
      format.html { redirect_to impressions_url, notice: 'Impression was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_impression
      @impression = Impression.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def impression_params
      params.fetch(:impression, {})
    end
end
