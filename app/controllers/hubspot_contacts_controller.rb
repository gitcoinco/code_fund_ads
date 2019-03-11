class HubspotContactsController < ApplicationController
  before_action :authenticate_administrator!

  def create
    user = User.find(params[:user_id])
    user_attrs = {
      firstname: user.first_name,
      lastname: user.last_name,
      roles: user.roles.join(";"),
    }

    if user.publisher?
      user_attrs[:property_urls] = user.properties.map(&:url).join("\n")
    end

    contact = Hubspot::Contact.createOrUpdate(user.email, user_attrs)

    user.hubspot_contact_vid = contact.vid
    user.save(validate: false)

    redirect_to user_path(user)
  end
end
