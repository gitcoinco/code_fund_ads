# frozen_string_literal: true

class ImagesController < ApplicationController
  before_action :set_imageable

  # GET /imageable/:imageable_gid/images/
  # GET /imageable/:imageable_gid/images.json
  def index
    @images = @imageable.images
  end

  # GET /imageable/:imageable_gid/images/1
  # GET /imageable/:imageable_gid/images/1.json
  def show
  end

  # GET /imageable/:imageable_gid/images/new
  def new
  end

  private

    def set_imageable
      @imageable = GlobalID.parse(params[:imageable_gid]).find
    end
end
