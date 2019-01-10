class AddToMailchimpListJob < ApplicationJob
  queue_as :default

  def perform(email_address, user_id = nil)
    email = EmailAddress.normal(email_address)
    user = User.where(id: user_id).first

    @gibbon = Gibbon::Request.new(api_key: ENV["MAILCHIMP_API_KEY"])
    @mailchimp_lists = {
      newsletter: ENV["MAILCHIMP_NEWSLETTER_ID"],
      advertiser: ENV["MAILCHIMP_ADVERTISER_LIST_ID"],
      publisher: ENV["MAILCHIMP_PUBLISHER_LIST_ID"],
    }

    add_to_list(:advertiser, email, user) if user&.advertiser?
    add_to_list(:publisher, email, user) if user&.publisher?
    add_to_list(:newsletter, email)
  end

  private

  def add_to_list(list, email, user = nil)
    body = {email_address: email, status: "subscribed"}
    body[:merge_fields] = {FNAME: user.first_name, LNAME: user.last_name} if user
    @gibbon.lists(@mailchimp_lists[list]).members(Digest::MD5.hexdigest(email)).upsert(body: body)

    CreateSlackNotificationJob.perform_later text: ":email: #{email} was added to the #{list} mailchimp list"
  end
end
