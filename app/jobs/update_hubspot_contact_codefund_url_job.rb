class UpdateHubspotContactCodefundUrlJob < ApplicationJob
  queue_as :low

  def perform(user)
    return unless ENV["HUBSPOT_PUBLISHER_AUTOMATION_ENABLED"] == "true"
    return unless user.hubspot_contact
    path = Rails.application.routes.url_helpers.user_path(user)
    user.hubspot_contact.update! codefund_url: "https://codefund.app#{path}"
  end
end
