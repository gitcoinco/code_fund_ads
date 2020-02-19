# == Schema Information
#
# Table name: creatives
#
#  id              :bigint           not null, primary key
#  body            :text
#  creative_type   :string           default("standard"), not null
#  cta             :string
#  headline        :string
#  name            :string           not null
#  status          :string           default("pending")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  legacy_id       :uuid
#  organization_id :bigint
#  user_id         :bigint           not null
#
# Indexes
#
#  index_creatives_on_creative_type    (creative_type)
#  index_creatives_on_organization_id  (organization_id)
#  index_creatives_on_user_id          (user_id)
#

require "test_helper"

class CreativeTest < ActiveSupport::TestCase
  setup do
    @campaign = campaigns(:premium)
    @creative = creatives(:premium)
  end

  test "body must not be blank" do
    @creative.update(body: "")
    assert_not @creative.valid?
    assert_equal ["is too short (minimum is 1 character)"], @creative.errors.messages[:body]
  end

  test "body must not be more than 255 characters" do
    @creative.update(body: ("a" * 256))
    assert_not @creative.valid?
    assert_equal ["is too long (maximum is 255 characters)"], @creative.errors.messages[:body]
  end

  test "headline must not be blank" do
    @creative.update(headline: "")
    assert_not @creative.valid?
    assert_equal ["is too short (minimum is 1 character)"], @creative.errors.messages[:headline]
  end

  test "headline must not be more than 255 characters" do
    @creative.update(headline: ("a" * 256))
    assert_not @creative.valid?
    assert_equal ["is too long (maximum is 255 characters)"], @creative.errors.messages[:headline]
  end

  test "cta must not be blank" do
    @creative.update(cta: "")
    assert_not @creative.valid?
    assert_equal ["is too short (minimum is 1 character)"], @creative.errors.messages[:cta]
  end

  test "cta must not be more than 255 characters" do
    @creative.update(cta: ("a" * 21))
    assert_not @creative.valid?
    assert_equal ["is too long (maximum is 20 characters)"], @creative.errors.messages[:cta]
  end

  test "name must not be blank" do
    @creative.update(name: "")
    assert_not @creative.valid?
    assert_equal ["is too short (minimum is 1 character)"], @creative.errors.messages[:name]
  end

  test "name must not be more than 255 characters" do
    @creative.update(name: ("a" * 256))
    assert_not @creative.valid?
    assert_equal ["is too long (maximum is 255 characters)"], @creative.errors.messages[:name]
  end

  test "status must not be valid" do
    @creative.update(status: "foobar")
    assert_not @creative.valid?
    assert_equal ["is not included in the list"], @creative.errors.messages[:status]
  end

  test "creative type must be valid" do
    @creative.update(creative_type: "")
    assert_not @creative.valid?
    assert_equal ["is not included in the list"], @creative.errors.messages[:creative_type]
  end

  test "cannot be destroyed if there are associated daily summaries" do
    DailySummary.create impressionable_type: "Campaign",
                        impressionable_id: @campaign.id,
                        scoped_by_type: "Creative",
                        scoped_by_id: @creative.id,
                        displayed_at_date: Date.today
    assert_not @creative.destroy
    assert_includes @creative.errors.messages[:base].to_s, "has associated"
  end
end
