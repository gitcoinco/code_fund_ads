class Comments::RichTextFormComponent < ApplicationComponent
  def initialize(commentable:)
    @commentable = commentable
  end

  private

  attr_reader :commentable
end
