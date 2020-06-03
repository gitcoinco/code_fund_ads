# See https://gorails.com/episodes/save-action-mailbox-html-emails-with-action-text
class IncomingMailbox < ApplicationMailbox
  include ActionView::Helpers::TextHelper

  before_processing :verify_participants

  def process
    delivered_at = begin
                     DateTime.parse(mail.raw_source.match(%r{Date: (.*)\r\n})[1])
                   rescue
                     inbound_email.created_at
                   end

    parent_email_id = Email.find_by(message_id: mail.in_reply_to)&.id

    email = Email.create \
      action_mailbox_inbound_email_id: inbound_email.id,
      sender: mail.from.first,
      recipients: (mail.to.to_a + mail.cc.to_a).uniq.compact.sort,
      message_id: mail.message_id,
      parent_id: parent_email_id,
      in_reply_to: mail.in_reply_to,
      subject: mail.subject,
      snippet: snippet,
      body: body,
      direction: direction,
      delivered_at: delivered_at,
      delivered_at_date: delivered_at,
      attachments: attachments.map { |a| a[:blob] }

    return unless email.persisted?

    email.participant_users.each do |user|
      EmailUser.where(user_id: user.id, email_id: email.id).first_or_create
    end
  end

  private

  # Only allow inbound emails with the following criteria:
  # 1. Sender or recipient must be either a publisher or advertiser
  # 2. Sender or recipient must include a CodeFund administrator with `record_inbound_emails` enabled
  def verify_participants
    recipients = (mail.to.to_a + mail.cc.to_a + [mail.from]).flatten.compact.uniq
    return bounced! unless User.non_administrators.exists?(email: recipients)
    return bounced! unless User.administrators.where(record_inbound_emails: true).exists?(email: recipients)
  end

  def direction
    User.administrators.exists?(email: mail.from) ? ENUMS::EMAIL_DIRECTIONS::OUTBOUND : ENUMS::EMAIL_DIRECTIONS::INBOUND
  end

  def attachments
    @_attachments = mail.attachments.map { |attachment|
      blob = ActiveStorage::Blob.create_after_upload!(
        io: StringIO.new(attachment.body.to_s),
        filename: attachment.filename,
        content_type: attachment.content_type
      )
      {original: attachment, blob: blob}
    }
  end

  def body
    if mail.multipart? && mail.html_part
      document = Nokogiri::HTML(mail.html_part.body.decoded)

      attachments.map do |attachment_hash|
        attachment = attachment_hash[:original]
        blob = attachment_hash[:blob]

        if attachment.content_id.present?
          # Remove the beginning and end < >
          content_id = attachment.content_id[1...-1]
          element = document.at_css "img[src='cid:#{content_id}']"
          next unless element
          element.replace "<action-text-attachment sgid=\"#{blob.attachable_sgid}\" content-type=\"#{attachment.content_type}\" filename=\"#{attachment.filename}\"></action-text-attachment>"
        end
      end

      document.at_css("body").inner_html.encode("utf-8")
    elsif mail.multipart? && mail.text_part
      mail.text_part.body.decoded
    else
      mail.decoded
    end
  end

  def snippet
    stripped_body = ActionView::Base.full_sanitizer.sanitize(body)
    truncate(stripped_body, length: 300)
  end
end
