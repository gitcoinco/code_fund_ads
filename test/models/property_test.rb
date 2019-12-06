# == Schema Information
#
# Table name: properties
#
#  id                             :bigint           not null, primary key
#  user_id                        :bigint           not null
#  property_type                  :string           not null
#  status                         :string           not null
#  name                           :string           not null
#  description                    :text
#  url                            :text             not null
#  ad_template                    :string
#  ad_theme                       :string
#  language                       :string           not null
#  keywords                       :string           default([]), not null, is an Array
#  prohibited_advertiser_ids      :bigint           default([]), not null, is an Array
#  prohibit_fallback_campaigns    :boolean          default(FALSE), not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  legacy_id                      :uuid
#  revenue_percentage             :decimal(, )      default(0.6), not null
#  assigned_fallback_campaign_ids :bigint           default([]), not null, is an Array
#  restrict_to_assigner_campaigns :boolean          default(FALSE), not null
#  fallback_ad_template           :string
#  fallback_ad_theme              :string
#  responsive_behavior            :string           default("none"), not null
#  audience_id                    :bigint
#  deleted_at                     :datetime
#

require "test_helper"

class PropertyTest < ActiveSupport::TestCase
  setup do
    @property = properties(:website)
  end

  test "language too short validation" do
    assert_not @property.update(language: "")
    assert_includes @property.errors.messages[:language].to_s, "too short"
  end

  test "language too long validation" do
    assert_not @property.update(language: ("x" * 256))
    assert_includes @property.errors.messages[:language].to_s, "too long"
  end

  test "name too short validation" do
    assert_not @property.update(name: "")
    assert_includes @property.errors.messages[:name].to_s, "too short"
  end

  test "name too long validation" do
    assert_not @property.update(name: ("x" * 256))
    assert_includes @property.errors.messages[:name].to_s, "too long"
  end

  test "property_type validation" do
    assert_not @property.update(property_type: "movie")
    assert_includes @property.errors.messages[:property_type].to_s, "not included"
  end

  test "responsive_behavior validation" do
    assert_not @property.update(responsive_behavior: "header")
    assert_includes @property.errors.messages[:responsive_behavior].to_s, "not included"
  end

  test "status validation" do
    assert_not @property.update(status: "whack")
    assert_includes @property.errors.messages[:status].to_s, "not included"
  end

  test "revenue_percentage too low validation" do
    assert_not @property.update(revenue_percentage: -1.0)
    assert_includes @property.errors.messages[:revenue_percentage].to_s, "must be greater than or equal to 0"
  end

  test "revenue_percentage too high validation" do
    assert_not @property.update(revenue_percentage: 2.0)
    assert_includes @property.errors.messages[:revenue_percentage].to_s, "must be less than or equal to 1"
  end

  test "url presence validation" do
    assert_not @property.update(url: "")
    assert_includes @property.errors.messages[:url].to_s, "can't be blank"
  end

  test "url format validation" do
    assert_not @property.update(url: "htp://www.example.com")
    assert_includes @property.errors.messages[:url].to_s, "must be a valid URL"
  end
end
