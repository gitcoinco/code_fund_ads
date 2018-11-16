require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "password_changed" do
    mail = UserMailer.password_changed("chris.knight@codefund.io")
    assert_equal "[CodeFund.io] Password Reset", mail.subject
    assert_equal ["chris.knight@codefund.io"], mail.to
    assert_equal ["noreply@codefund.io"], mail.from
  end
end
