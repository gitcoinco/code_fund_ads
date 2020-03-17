require "test_helper"

class CampaignsMailerTest < ActionMailer::TestCase
  def setup
    @user = users(:advertiser)
    @campaign = campaigns(:premium_bundled)
  end

  test "campaign paused" do
    email = CampaignsMailer.campaign_paused_email(@campaign, @user)
    assert_emails 1 do
      email.deliver_later
    end

    assert_equal email.to, ["team@codefund.io"]
    assert_equal email.from, ["alerts@codefund.io"]
    assert_equal email.subject, "A campaign has been paused by #{@user.name}"
    assert_match @campaign.name, email.body.encoded
  end
end
