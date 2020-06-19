class PixelsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization
  before_action :set_pixel, only: [:show, :edit, :update, :destroy]
  before_action :authorize_edit!, except: [:index]

  def index
    pixels = @organization.pixels.order(name: :asc)
    @pagy, @pixels = pagy(pixels)
  end

  def new
    @pixel = @organization.pixels.build(user: current_user)
  end

  def create
    @pixel = @organization.pixels.build(pixel_params)

    respond_to do |format|
      if @pixel.save
        format.html { redirect_to pixels_path(@organization), notice: "Pixel was successfully created" }
        format.json { render :show, status: :created, location: pixel_path(@organization, @pixel) }
      else
        format.html { render :new }
        format.json { render json: @pixel.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @pixel.update(pixel_params)

    respond_to do |format|
      if @pixel.save
        format.html { redirect_to pixel_path(@organization, @pixel), notice: "Pixel was successfully updated." }
        format.json { render :show, status: :ok, location: pixel_path(@organization, @pixel) }
      else
        format.html { render :edit }
        format.json { render json: @pixel.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @pixel.destroy
        format.html { redirect_to pixels_path(@organization), notice: "Pixel was deleted successfully" }
        format.json { head :no_content }
      else
        format.html { redirect_to pixels_path(@organization), notice: @organization.errors.messages.to_s }
        format.json { render json: @organization_user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def authorize_edit!
    unless authorized_user.can_edit_organization_users?(@organization)
      redirect_to organization_users_path(@organization), notice: "You do not have permission to update membership settings."
    end
  end

  def set_organization
    @organization = Current.organization
  end

  def set_pixel
    @pixel = @organization.pixels.find(params[:id])
  end

  def pixel_params
    params.require(:pixel).permit(:description, :name, :value, :user_id).tap do |whitelisted|
      whitelisted[:user_id] = if authorized_user.can_admin_system?
        params[:pixel][:user_id]
      else
        current_user.id
      end
    end
  end
end
