class CreativesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_creative_search, only: [:index]
  before_action :set_creative, only: [:show, :edit, :update, :destroy]

  def index
    creatives = current_user.creatives.order(:name).includes(:user)
    creatives = @creative_search.apply(creatives)
    @pagy, @creatives = pagy(creatives, items: 10)
  end

  def new
    @creative = current_user.creatives.build
  end

  def create
    @creative = current_user.creatives.build(creative_params)

    respond_to do |format|
      if @creative.save
        @creative.assign_images(creative_image_params)
        format.html { redirect_to @creative, notice: "Creative was successfully created." }
        format.json { render :show, status: :created, location: @creative }
      else
        format.html { render :new }
        format.json { render json: @creative.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @creative.update(creative_params)
        @creative.assign_images(creative_image_params)
        format.html { redirect_to @creative, notice: "Creative was successfully updated." }
        format.json { render :show, status: :ok, location: @creative }
      else
        format.html { render :edit }
        format.json { render json: @creative.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @creative.campaigns.empty?
      @creative.destroy
      respond_to do |format|
        format.html { redirect_to creatives_url, notice: "Creative was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to creatives_url, alert: "We are unable to delete a creative that has been used" }
        format.json { head :no_content }
      end
    end
  end

  private

  def set_creative_search
    @creative_search = GlobalID.parse(session[:creative_search]).find if session[:creative_search].present?
    @creative_search ||= CreativeSearch.new
  end

  def set_creative
    @creative = if authorized_user.can_admin_system?
      Creative.find(params[:id])
    else
      current_user.creatives.find(params[:id])
    end
  end

  def creative_params
    params.require(:creative).permit(:name, :headline, :body)
  end

  def creative_image_params
    params.require(:creative).permit(:small_blob_id, :large_blob_id, :wide_blob_id)
  end
end
