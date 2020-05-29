# == Schema Information
#
# Table name: email_users
#
#  id       :bigint           not null, primary key
#  read_at  :datetime
#  email_id :bigint           not null
#  user_id  :bigint           not null
#
# Indexes
#
#  index_email_users_on_email_id_and_user_id  (email_id,user_id) UNIQUE
#
require "test_helper"

class EmailUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
