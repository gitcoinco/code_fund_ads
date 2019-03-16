class CreateHubspotAdvertiserDealJob < ApplicationJob
  queue_as :low

  def perform(applicant_id)
    return unless ENV["HUBSPOT_ENABLED"] == "true"

    applicant = Applicant.find(applicant_id)

    company = Hubspot::Company.create!(applicant.company_name)
    contact = Hubspot::Contact.createOrUpdate(applicant.email, {
      firstname: applicant.first_name,
      lastname: applicant.last_name,
      property_urls: applicant.url,
      monthly_budget: applicant.monthly_budget,
    })
    Hubspot::Company.add_contact! company.vid, contact.vid

    deal = Hubspot::Deal.create!(nil, [company.vid], [contact.vid],
      dealname: applicant.company_name,
      dealstage: ENV["ADVERTISER_INTERESTED_DEALSTAGE"],
      hubspot_owner_id: ENV["OWNER_ID"],
      pipeline: ENV["ADVERTISER_DEAL_PIPELINE"],
      role: "advertiser",
      url: applicant.url,
      monthly_visitors: applicant.monthly_visitors)

    applicant.hubspot_deal_vid = deal.deal_id
    applicant.hubspot_contact_vid = contact.vid
    applicant.hubspot_company_vid = company.vid
    applicant.save
  end
end
