class ImageSearchesController < ApplicationController
  before_action :set_imageable

  def create
    session[:image_search] = ImageSearch.new(image_search_params).to_gid_param
    redirect_to images_path
  end

  def update
    if session[:image_search].present?
      image_search = GlobalID.parse(session[:image_search]).find if session[:image_search].present?
      session[:image_search] = ImageSearch.new(image_search.to_h(params[:remove])).to_gid_param
    end
    redirect_to images_path(@imageable.to_gid_param)
  end

  def destroy
    session[:image_search] = ImageSearch.new.to_gid_param
    redirect_to images_path(@imageable.to_gid_param)
  end

  private

  def set_imageable
    @imageable = GlobalID.parse(params[:imageable_gid]).find
  end

  def image_search_params
    params.require(:image_search).permit(
      :description,
      :filename,
      :name,
      :user_id,
      formats: [],
    )
  end
end
