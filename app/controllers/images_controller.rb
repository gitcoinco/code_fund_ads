# frozen_string_literal: true

class ImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_authorizable
  before_action :set_imageable
  before_action :set_image_search, only: [:index]

  def index
    return render_forbidden unless authorizable.can_view_images?(@imageable)
    images = @imageable.images
    return redirect_to(new_image_path) if images.count == 0
    images = @image_search.apply(images.attachments)
    @pagy, @images = pagy(images)
  end

  def edit
    image = @imageable.images.find(params[:id])
    return render_forbidden unless authorizable.can_update?(image)
    @image = Image.new(image)
  end

  def update
    image = @imageable.images.find(params[:id])
    return render_forbidden unless authorizable.can_update?(image)
    image.blob.metadata = image.blob.metadata.merge(image_params)
    image.blob.save
    flash[:notice] = I18n.t("images.update.success")
    redirect_to edit_image_path(@imageable.to_gid_param, image)
  end

  def create
    @imageable.images.attach *imageable_params[:images]
    head :ok
  end

  def destroy
    image = ActiveStorage::Attachment.find(params[:id])
    return render_forbidden unless authorizable.can_destroy?(image)
    image.purge
    flash[:notice] = I18n.t("images.destroy.success")
    redirect_to images_path(@imageable.to_gid_param)
  end

  private

    def set_authorizable
      @authorizable = ImagesAuthorizer.new(current_user)
    end

    def set_imageable
      @imageable = GlobalID.parse(params[:imageable_gid]).find
    end

    def set_image_search
      @image_search = GlobalID.parse(session[:image_search]).find if session[:image_search].present?
      @image_search ||= ImageSearch.new
    end

    def imageable_params
      params.require(:imageable).permit(images: [])
    end

    def image_params
      params.require(:image).permit(:format, :name, :description)
    end
end
