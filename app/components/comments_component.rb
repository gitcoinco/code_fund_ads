class CommentsComponent < ApplicationComponent
  def initialize(comments:, commentable:)
    @comments = comments
    @commentable = commentable
  end

  private

  attr_accessor :comments, :commentable
end
