class CreativesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_creative, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_creative_create_rights!, only: [:new, :create]
  before_action :authenticate_creative_update_rights!, only: [:edit, :update]

  def index
    creatives = Current.organization&.creatives&.order(:name)&.includes(:user)
    @pagy, @creatives = pagy(creatives, items: 10)
  end

  def new
    @creative = current_user.creatives.build

    if params[:clone].present?
      cloned_creative = Creative.find(params[:clone])
      if cloned_creative.present?
        @creative.attributes = cloned_creative.attributes
        @creative.user = cloned_creative.user
        @creative.status = "pending"
      end
    end
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
        @creative.assign_images creative_image_params
        @creative.update_columns status: ENUMS::CREATIVE_STATUSES::PENDING if @creative.active? && !authorized_user(true).can_admin_system?

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

  def set_creative
    @creative = if authorized_user(true).can_admin_system?
      Creative.find(params[:id])
    else
      Current.organization&.creatives&.find(params[:id])
    end
  end

  def creative_params
    params.require(:creative).permit(:creative_type, :name, :headline, :body, :cta).tap do |whitelisted|
      whitelisted[:status] = params[:creative][:status] if authorized_user(true).can_admin_system?
    end
  end

  def creative_image_params
    params.require(:creative).permit(:icon_blob_id, :small_blob_id, :large_blob_id, :wide_blob_id, :sponsor_blob_id)
  end

  def authenticate_creative_create_rights!
    return render_forbidden unless authorized_user(true).can_create_creative?
  end

  def authenticate_creative_update_rights!
    return render_forbidden unless authorized_user(true).can_edit_creative?(@creative)
  end
end
