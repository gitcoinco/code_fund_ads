require "test_helper"

class UsersMailerTest < ActionMailer::TestCase
  def setup
    @user = users(:publisher)
  end

  test "new property" do
    email = UsersMailer.new_consolidated_screening_list_flag_email(@user)
    assert_emails 1 do
      email.deliver_later
    end

    assert_equal email.to, ["team@codefund.io"]
    assert_equal email.from, ["alerts@codefund.io"]
    assert_equal email.subject, "Consolidated Screening List Flagged: #{@user.name}"
    assert_match @user.name, email.body.encoded
  end
end
