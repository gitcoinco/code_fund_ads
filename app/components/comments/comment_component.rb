class Comments::CommentComponent < ApplicationComponent
  def initialize(comment:)
    @comment = comment
  end

  private

  attr_reader :comment
end
