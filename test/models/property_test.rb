# == Schema Information
#
# Table name: properties
#
#  id                             :bigint           not null, primary key
#  ad_template                    :string
#  ad_theme                       :string
#  assigned_fallback_campaign_ids :bigint           default([]), not null, is an Array
#  deleted_at                     :datetime
#  description                    :text
#  fallback_ad_template           :string
#  fallback_ad_theme              :string
#  keywords                       :string           default([]), not null, is an Array
#  language                       :string           not null
#  name                           :string           not null
#  prohibit_fallback_campaigns    :boolean          default(FALSE), not null
#  prohibited_organization_ids    :bigint           default([]), not null, is an Array
#  property_type                  :string           default("website"), not null
#  responsive_behavior            :string           default("none"), not null
#  restrict_to_assigner_campaigns :boolean          default(FALSE), not null
#  revenue_percentage             :decimal(, )      default(0.6), not null
#  status                         :string           not null
#  url                            :text             not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  audience_id                    :bigint
#  legacy_id                      :uuid
#  user_id                        :bigint           not null
#
# Indexes
#
#  index_properties_on_assigned_fallback_campaign_ids  (assigned_fallback_campaign_ids) USING gin
#  index_properties_on_audience_id                     (audience_id)
#  index_properties_on_keywords                        (keywords) USING gin
#  index_properties_on_name                            (lower((name)::text))
#  index_properties_on_prohibited_organization_ids     (prohibited_organization_ids) USING gin
#  index_properties_on_property_type                   (property_type)
#  index_properties_on_status                          (status)
#  index_properties_on_user_id                         (user_id)
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
    assert_includes @property.errors.messages[:url].to_s, "is invalid"
  end

  test "url format validation" do
    assert_not @property.update(url: "htp://www.example.com")
    assert_includes @property.errors.messages[:url].to_s, "is invalid"
  end

  test "cannot be destroyed if there are associated daily summaries" do
    DailySummary.create impressionable_type: "Campaign",
                        impressionable_id: campaigns(:premium).id,
                        scoped_by_type: "Property",
                        scoped_by_id: @property.id,
                        displayed_at_date: Date.today
    assert_not @property.destroy
    assert_includes @property.errors.messages[:base].to_s, "has associated"
  end
end
