class CreatePublisherFromHubspotContactJob < ApplicationJob
  queue_as :low

  # Hubspot::Contact#properties keys:
  # [
  #   "createdate",
  #   "email",
  #   "engagements_last_meeting_booked",
  #   "first_deal_created_date",
  #   "firstname",
  #   "hs_all_accessible_team_ids",
  #   "hs_all_owner_ids",
  #   "hs_all_team_ids",
  #   "hs_analytics_average_page_views",
  #   "hs_analytics_first_timestamp",
  #   "hs_analytics_first_touch_converting_campaign",
  #   "hs_analytics_first_url",
  #   "hs_analytics_first_visit_timestamp",
  #   "hs_analytics_last_referrer",
  #   "hs_analytics_last_timestamp",
  #   "hs_analytics_last_touch_converting_campaign",
  #   "hs_analytics_last_url",
  #   "hs_analytics_last_visit_timestamp",
  #   "hs_analytics_num_event_completions",
  #   "hs_analytics_num_page_views",
  #   "hs_analytics_num_visits",
  #   "hs_analytics_revenue",
  #   "hs_analytics_source",
  #   "hs_analytics_source_data_1",
  #   "hs_analytics_source_data_2",
  #   "hs_email_domain",
  #   "hs_email_optout",
  #   "hs_email_optout_6125111",
  #   "hs_email_optout_6125161",
  #   "hs_email_optout_6125960",
  #   "hs_email_optout_6185948",
  #   "hs_email_optout_6314007",
  #   "hs_email_quarantined",
  #   "hs_email_recipient_fatigue_recovery_time",
  #   "hs_lifecyclestage_opportunity_date",
  #   "hs_lifecyclestage_subscriber_date",
  #   "hs_predictivecontactscore_v2",
  #   "hs_sales_email_last_opened",
  #   "hs_sales_email_last_replied",
  #   "hs_social_facebook_clicks",
  #   "hs_social_google_plus_clicks",
  #   "hs_social_last_engagement",
  #   "hs_social_linkedin_clicks",
  #   "hs_social_num_broadcast_clicks",
  #   "hs_social_twitter_clicks",
  #   "hubspot_owner_assigneddate",
  #   "hubspot_owner_id",
  #   "hubspot_team_id",
  #   "lastmodifieddate",
  #   "lastname",
  #   "lifecyclestage",
  #   "monthly_visitors",
  #   "notes_last_contacted",
  #   "notes_last_updated",
  #   "notes_next_activity_date",
  #   "num_associated_deals",
  #   "num_contacted_notes",
  #   "num_conversion_events",
  #   "num_notes",
  #   "num_unique_conversion_events",
  #   "property_urls",
  #   "recent_deal_amount",
  #   "recent_deal_close_date",
  #   "total_revenue"
  # ]
  def perform(hubspot_contact_vid)
    return unless ENV["HUBSPOT_PUBLISHER_AUTOMATION_ENABLED"] == "true"
    hubspot_contact = Hubspot::Contact.find_by_id(hubspot_contact_vid)
    return unless hubspot_contact

    email = hubspot_contact["email"].to_s.strip
    return unless email.present?

    user = User.where(email: [EmailAddress.normal(email), EmailAddress.canonical(email)]).first
    user ||= User.invite!(
      email: EmailAddress.normal(email),
      first_name: hubspot_contact["firstname"].to_s.strip,
      last_name: hubspot_contact["lastname"].to_s.strip,
      roles: [ENUMS::USER_ROLES::PUBLISHER],
      hubspot_contact_vid: hubspot_contact_vid,
      website_url: hubspot_contact["website"].to_s.strip,
      referring_user_id: referring_user_id(hubspot_contact),
      utm_source: hubspot_contact["utm_source"],
      utm_medium: hubspot_contact["utm_medium"],
      utm_campaign: hubspot_contact["utm_campaign"],
      utm_term: hubspot_contact["utm_term"],
      utm_content: hubspot_contact["utm_content"],
    )

    UpdateHubspotContactCodefundUrlJob.perform_later user

    begin
      urls = hubspot_contact["additional_websites"].to_s.split
      urls << hubspot_contact["website"].to_s

      urls.each do |url|
        url = url.strip
        next unless url.present?
        user.properties.where(url: url).first_or_create!(
          property_type: ENUMS::PROPERTY_TYPES::WEBSITE,
          status: ENUMS::PROPERTY_STATUSES::PENDING,
          language: ENUMS::LANGUAGES::ENGLISH,
          name: url[0, 255],
          revenue_percentage: 0.6,
          keywords: hubspot_contact["website_keywords"].to_s.split(";")
        )
      rescue => e
        Rollbar.error e
      end
    rescue => e
      Rollbar.error e
    end
  end

  private

  def referring_user_id(hubspot_contact)
    return nil unless hubspot_contact["referral_code"].present?
    User.find_by(referral_code: hubspot_contact["referral_code"])&.id
  end
end
