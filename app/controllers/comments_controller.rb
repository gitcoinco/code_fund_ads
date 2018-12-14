class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:index], if: -> { params[:user_id].present? }
  before_action :set_campaign, only: [:index], if: -> { params[:campaign_id].present? }
  before_action :set_property, only: [:index], if: -> { params[:property_id].present? }
  before_action :set_applicant, only: [:index], if: -> { params[:applicant_id].present? }
  before_action :set_commentable, only: [:show, :create]

  def index
    @comments = @commentable.comment_threads

    render "/comments/for_user/index"      if @commentable.is_a? User
    render "/comments/for_campaign/index"  if @commentable.is_a? Campaign
    render "/comments/for_property/index"  if @commentable.is_a? Property
    render "/comments/for_applicant/index" if @commentable.is_a? Applicant
  end

  def create
    comment = Comment.build_from(@commentable, current_user.id, params[:body])
    comment.save
    redirect_back fallback_location: root_path
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_back fallback_location: root_path
  end

  private

  def set_user
    @commentable = User.find(params[:user_id])
  end

  def set_campaign
    @commentable = Campaign.find(params[:campaign_id])
  end

  def set_property
    @commentable = Property.find(params[:property_id])
  end

  def set_applicant
    @commentable = Applicant.find(params[:applicant_id])
  end

  def set_commentable
    @commentable = GlobalID::Locator.locate_signed(params[:sgid])
  end
end
