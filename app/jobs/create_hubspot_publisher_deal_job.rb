class CreateHubspotPublisherDealJob < ApplicationJob
  queue_as :low

  def perform(applicant_id)
    return unless ENV["HUBSPOT_ENABLED"] == "true"

    applicant = Applicant.find(applicant_id)

    contact = Hubspot::Contact.createOrUpdate(applicant.email, {
      firstname: applicant.first_name,
      lastname: applicant.last_name,
      property_urls: applicant.url,
      monthly_visitors: applicant.monthly_visitors,
    })

    deal = Hubspot::Deal.create!(nil, [nil], [contact.vid],
      dealname: "#{applicant.first_name} #{applicant.last_name}",
      dealstage: ENV["PUBLISHER_INTERESTED_DEALSTAGE"],
      hubspot_owner_id: ENV["OWNER_ID"],
      pipeline: ENV["PUBLISHER_DEAL_PIPELINE"],
      role: "publisher",
      url: applicant.url,
      monthly_visitors: applicant.monthly_visitors)

    applicant.hubspot_deal_vid = deal.deal_id
    applicant.hubspot_contact_vid = contact.vid
    applicant.save
  end
end
