class CreativesController < ApplicationController
  include Sortable
  include Scopable

  before_action :authenticate_user!
  before_action :set_creative, only: [:show, :edit, :update, :destroy]
  before_action :authorize_new!, only: [:new, :create]
  before_action :authorize_edit!, only: [:edit, :update]

  set_default_sorted_by :name

  def index
    creatives = scope_list(Creative).where(organization: Current.organization)&.order(order_by)&.includes(:user)
    @pagy, @creatives = pagy(creatives, page: @page)
  end

  def new
    @creative = current_user.creatives.build

    if params[:clone].present?
      cloned_creative = Creative.find(params[:clone])
      if cloned_creative.present?
        @creative.attributes = cloned_creative.attributes
        @creative.user = cloned_creative.user
        @creative.status = "pending"
        @creative.cloned_images = {
          icon: cloned_creative.icon_image,
          small: cloned_creative.small_image,
          large: cloned_creative.large_image,
          wide: cloned_creative.wide_image
        }
      end
    end
  end

  def create
    @creative = current_user.creatives.build(creative_params)
    images_valid = creative_image_params_validation.valid?

    respond_to do |format|
      if @creative.save && images_valid
        @creative.assign_images(creative_image_params)
        format.html { redirect_to @creative, notice: "Creative was successfully created." }
        format.json { render :show, status: :created, location: @creative }
      else
        @creative.errors.merge! creative_image_params_validation.errors
        format.html { render :new }
        format.json { render json: @creative.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    images_valid = creative_image_params_validation.valid?

    respond_to do |format|
      if @creative.update(creative_params) && images_valid
        @creative.assign_images creative_image_params
        @creative.update_columns status: ENUMS::CREATIVE_STATUSES::PENDING unless authorized_user(true).can_edit_creative?(@creative)

        format.html { redirect_to @creative, notice: "Creative was successfully updated." }
        format.json { render :show, status: :ok, location: @creative }
      else
        @creative.errors.merge! creative_image_params_validation.errors
        format.html { render :edit }
        format.json { render json: @creative.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @creative.campaigns.empty?
      @creative.update(status: ENUMS::CREATIVE_STATUSES::ARCHIVED)
      respond_to do |format|
        format.html { redirect_to creatives_url, notice: "Creative was successfully archived." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to creatives_url, alert: "We are unable to delete a creative that is being used" }
        format.json { head :no_content }
      end
    end
  end

  protected

  def set_creative
    @creative = if authorized_user(true).can_admin_system?
      Creative.find(params[:id])
    else
      Current.organization&.creatives&.find(params[:id])
    end
  end

  def set_sortable_columns
    @sortable_columns ||= %w[
      created_at
      name
      status
      updated_at
      user.first_name
    ]
  end

  def set_scopable_values
    @scopable_values ||= ["all", ENUMS::CREATIVE_STATUSES.values].flatten
  end

  private

  def creative_params
    params.require(:creative).permit(:creative_type, :name, :headline, :body, :cta).tap do |whitelisted|
      whitelisted[:status] = params[:creative][:status] if authorized_user(true).can_edit_creatives_without_approval?(Current.organization)
    end
  end

  def creative_image_params
    params.require(:creative).permit(:icon_blob_id, :small_blob_id, :large_blob_id, :wide_blob_id, :sponsor_blob_id)
  end

  def creative_image_params_validation
    @creative_image_params_validation ||= CreativeImageParamsValidator.new(creative_image_params)
  end

  def authorize_new!
    render_forbidden unless authorized_user(true).can_create_creative?
  end

  def authorize_edit!
    render_forbidden unless authorized_user(true).can_edit_creative?(@creative)
  end
end
