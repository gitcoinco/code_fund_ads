# == Schema Information
#
# Table name: campaign_bundles
#
#  id              :bigint           not null, primary key
#  end_date        :date             not null
#  name            :string           not null
#  region_ids      :bigint           default([]), is an Array
#  start_date      :date             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_campaign_bundles_on_end_date    (end_date)
#  index_campaign_bundles_on_name        (lower((name)::text))
#  index_campaign_bundles_on_region_ids  (region_ids) USING gin
#  index_campaign_bundles_on_start_date  (start_date)
#

require "test_helper"

class CampaignBundleTest < ActiveSupport::TestCase
  test "to_stashable_attributes" do
    campaign = campaigns(:premium_bundled)
    bundle = campaign.campaign_bundle
    actual = bundle.to_stashable_attributes
    expected = {
      "id" => bundle.id,
      "organization_id" => bundle.organization_id,
      "user_id" => bundle.user_id,
      "name" => bundle.name,
      "start_date" => bundle.start_date.iso8601,
      "end_date" => bundle.end_date.iso8601,
      "region_ids" => bundle.region_ids,
      "created_at" => bundle.created_at.iso8601(3),
      "updated_at" => bundle.updated_at.iso8601(3),
      :campaigns_attributes =>
      [{"campaign_bundle_id" => bundle.id,
        "id" => campaign.id,
        "keywords" => campaign.keywords,
        "negative_keywords" => campaign.negative_keywords,
        "organization_id" => bundle.organization_id,
        "user_id" => bundle.user_id,
        "region_ids" => bundle.region_ids,
        "start_date" => bundle.start_date.iso8601,
        "end_date" => bundle.end_date.iso8601,
        "country_codes" => bundle.regions.map(&:country_codes).flatten.sort,
        "audience_ids" => campaign.audience_ids,
        "province_codes" => campaign.province_codes,
        "creative_ids" => campaign.creative_ids,
        "creative_id" => campaign.creative_id,
        "status" => campaign.status,
        "name" => campaign.name,
        "url" => campaign.url,
        "updated_at" => campaign.updated_at.iso8601(3),
        "total_budget_cents" => campaign.total_budget_cents,
        "total_budget_currency" => campaign.total_budget_currency,
        "daily_budget_cents" => campaign.daily_budget_cents,
        "daily_budget_currency" => campaign.daily_budget_currency,
        "hourly_budget_cents" => campaign.hourly_budget_cents,
        "hourly_budget_currency" => campaign.hourly_budget_currency,
        "ecpm_cents" => campaign.ecpm_cents,
        "ecpm_currency" => campaign.ecpm_currency,
        "assigned_property_ids" => campaign.assigned_property_ids,
        "fallback" => campaign.fallback,
        "core_hours_only" => campaign.core_hours_only,
        "weekdays_only" => campaign.weekdays_only,
        "created_at" => campaign.created_at.iso8601(3),
        "legacy_id" => campaign.legacy_id,
        "job_posting" => campaign.job_posting,
        "fixed_ecpm" => campaign.fixed_ecpm,
        "prohibited_property_ids" => campaign.prohibited_property_ids,
        "paid_fallback" => campaign.paid_fallback,
        "ecpm_multiplier" => campaign.ecpm_multiplier.to_s,
        :temporary_id => campaign.temporary_id}]
    }

    diff = Hashdiff.diff(expected.stringify_keys, actual.stringify_keys)
    assert diff.blank?
  end
end
