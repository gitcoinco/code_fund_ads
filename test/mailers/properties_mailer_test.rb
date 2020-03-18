require "test_helper"

class PropertiesMailerTest < ActionMailer::TestCase
  def setup
    @property = properties(:website)
  end

  test "new property" do
    email = PropertiesMailer.new_property_email(@property)
    assert_emails 1 do
      email.deliver_later
    end

    assert_equal email.to, ["team@codefund.io"]
    assert_equal email.from, ["alerts@codefund.io"]
    assert_equal email.subject, "A property has been added by #{@property.user.name}"
    assert_match @property.name, email.body.encoded
  end

  test "impressions drop" do
    email = PropertiesMailer.impressions_drop_email([@property])
    assert_emails 1 do
      email.deliver_later
    end

    assert_equal email.to, ["team@codefund.io"]
    assert_equal email.from, ["alerts@codefund.io"]
    assert_equal email.subject, "1 properties with a dramatic drop in impressions"
    assert_match @property.name, email.body.encoded
  end
end
