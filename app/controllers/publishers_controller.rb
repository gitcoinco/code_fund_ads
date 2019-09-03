class PublishersController < ApplicationController
  def index
    @testimonials = ButterCMS::Content.fetch([:publisher_testimonials])&.data&.publisher_testimonials || []
  end
end
