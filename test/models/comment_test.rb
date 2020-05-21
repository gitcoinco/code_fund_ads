# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  body             :text
#  commentable_type :string
#  lft              :bigint
#  rgt              :bigint
#  subject          :string
#  title            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :bigint
#  parent_id        :bigint
#  user_id          :bigint           not null
#
# Indexes
#
#  index_comments_on_commentable_id_and_commentable_type  (commentable_id,commentable_type)
#  index_comments_on_user_id                              (user_id)
#
require "test_helper"

class CommentTest < ActiveSupport::TestCase
  setup do
    @commentable = organizations(:default)
    @user = users(:administrator)
  end

  test "#build_from" do
    comment = Comment.build_from(@commentable, @user.id, "<div>Test comment.</div>")
    assert_equal @commentable.id, comment.commentable_id
    assert_equal @commentable.class.name, comment.commentable_type
    assert_equal ActionText::RichText, comment.content.class
    assert_equal @user.id, comment.user_id
  end

  test "#find_commentable" do
    comment = create_comment(commentable: @commentable, user: @user)
    comment.save

    assert_equal @commentable, Comment.find_commentable(comment.commentable_type, comment.commentable_id)
  end

  test "#find_comments_for_commentable" do
    comment = create_comment(commentable: @commentable, user: @user)
    comment.save

    assert_equal [comment], Comment.find_comments_for_commentable(comment.commentable_type, comment.commentable_id)
  end

  test "#find_comments_by_user" do
    comment = create_comment(commentable: @commentable, user: @user)
    comment.save

    assert_equal [comment], Comment.find_comments_by_user(@user)
  end
end
