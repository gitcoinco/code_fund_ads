class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_commentable, only: :create
  before_action :set_comment, only: :destroy
  before_action :authorize_create!, only: :create
  before_action :authorize_destroy!, only: :destroy

  def create
    comment = Comment.build_from(@commentable, current_user.id, comment_params[:content])
    comment.save
    redirect_back fallback_location: root_path
  end

  def destroy
    @comment.destroy
    redirect_back fallback_location: root_path
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_commentable
    @commentable = GlobalID::Locator.locate_signed(comment_params[:sgid])
  end

  def comment_params
    params.require(:comment).permit(:sgid, :content)
  end

  def authorize_create!
    render_forbidden unless authorized_user.can_create_comment?
  end

  def authorize_destroy!
    render_forbidden unless authorized_user.can_destroy_comment?
  end
end
