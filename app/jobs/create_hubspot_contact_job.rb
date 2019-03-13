class CreateHubspotContactJob < ApplicationJob
  queue_as :low

  def perform(user_id)
    return unless ENV["HUBSPOT_ENABLED"] == "true"

    user = User.find(user_id)

    contact = Hubspot::Contact.createOrUpdate(user.email, {
      firstname: user.first_name,
      lastname: user.last_name,
      roles: user.roles,
      company: user.company_name,
      github_username: user.github_username,
    })

    user.update(hubspot_contact_vid: contact.vid)
  end
end
