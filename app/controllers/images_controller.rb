class ImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_imageable

  def index
    return render_forbidden unless authorized_user.can_view_imageable?(@imageable)
    @images = @imageable.images
    return redirect_to(new_image_path) if @images.count == 0
  end

  def create
    @imageable.images.attach(*imageable_params[:images])
    head :ok
  end

  def edit
    image = @imageable.images.find(params[:id])
    return render_forbidden unless authorized_user.can_update_image?(image)
    @image = Image.new(image)
  end

  def update
    image = @imageable.images.find(params[:id])
    return render_forbidden unless authorized_user.can_update_image?(image)
    image.blob.metadata = image.blob.metadata.merge(image_params)
    image.blob.save
    flash[:notice] = I18n.t("images.update.success")
    redirect_to edit_image_path(@imageable.to_gid_param, image)
  end

  def destroy
    image = ActiveStorage::Attachment.find(params[:id])
    if authorized_user.can_destroy_image?(image)
      image.purge
      flash[:notice] = I18n.t("images.destroy.success")
    else
      flash[:notice] = I18n.t("images.destroy.failure")
    end
    redirect_to images_path(@imageable.to_gid_param)
  end

  private

  def set_imageable
    @imageable = GlobalID.parse(params[:imageable_gid]).find
  end

  def imageable_params
    params.require(:imageable).permit(images: [])
  end

  def image_params
    params.require(:image).permit(
      :description,
      :format,
      :name,
    )
  end
end
