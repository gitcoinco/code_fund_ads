class Comments::FormComponent < ApplicationComponent
  def initialize(commentable:)
    @commentable = commentable
  end

  private

  attr_reader :commentable
end
