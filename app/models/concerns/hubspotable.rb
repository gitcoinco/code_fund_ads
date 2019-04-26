module Hubspotable
  extend ActiveSupport::Concern

  def hubspot_company_vid?
    hubspot_company_vid.present?
  end

  def hubspot_contact_vid?
    hubspot_contact_vid.present?
  end

  def hubspot_deal_vid?
    hubspot_deal_vid.present?
  end

  def hubspot_company
    @hubspot_company ||= Hubspot::Company.find_by_id(hubspot_company_vid) if hubspot_company_vid?
  end

  def hubspot_contact
    @hubspot_contact ||= Hubspot::Contact.find_by_id(hubspot_contact_vid) if hubspot_contact_vid?
  end

  def hubspot_deal
    @hubspot_deal ||= Hubspot::Deal.find(hubspot_deal_vid) if hubspot_deal_vid?
  end

  def hubspot_deals
    @hubspot_deals ||= Hubspot::Deal.find_by_contact(hubspot_contact) if hubspot_contact
  end
end
