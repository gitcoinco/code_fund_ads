# frozen_string_literal: true

class ImagesController < ApplicationController
  before_action :set_imageable

  # GET /imageable/:imageable_gid/images/
  # GET /imageable/:imageable_gid/images.json
  def index
    @images = @imageable.images
    redirect_to new_image_path if @images.count == 0
  end

  # GET /imageable/:imageable_gid/images/1
  # GET /imageable/:imageable_gid/images/1.json
  def show
    @image = @imageable.images.find(params[:id])
  end

  # GET /imageable/:imageable_gid/images/new
  def new
  end

  # POST /imageable/:imageable_gid/images
  # POST /imageable/:imageable_gid/images.json
  def create
    @imageable.images.attach *imageable_params[:images]
    head :ok
  end

  # DELETE /imageable/:imageable_gid/images/1
  # DELETE /imageable/:imageable_gid/images/1.json
  def destroy
    image = ActiveStorage::Attachment.find(params[:id])
    image.purge
    redirect_to images_path(@imageable.to_gid_param)
  end

  private

    def set_imageable
      @imageable = GlobalID.parse(params[:imageable_gid]).find
    end

    def imageable_params
      params.require(:imageable).permit(images: [])
    end
end
