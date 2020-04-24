module Extensions
  module ActionMailboxInboundEmail
    extend ActiveSupport::Concern

    included do
      scope :with_user, ->(user) { where("sender_id = ? OR ?::text = ANY (to_ids) OR ?::text = ANY (cc_ids)", user.id, user.id, user.id)}
      scope :sent_by, ->(user) { where(sender_id: user.id) }
      scope :sent_to, ->(user) { where("?::text = ANY (to_ids)", user.id) }
      scope :cc_to, ->(user) { where("?::text = ANY (cc_ids)", user.id) }
    end

    def sender
      @sender ||= User.find_by(id: sender_id)
    end

    def add_metadata!
      return unless User.exists?(email: mail.from)
      
      self.delivered_at = DateTime.parse(mail.raw_source.match(%r{Date: (.*)\r\n})[1]) rescue nil
      self.sender_id = User.find_by(email: mail.from)&.id
      self.to_ids = User.where(email: mail.to)&.map(&:id)
      self.cc_ids = User.where(email: mail.cc)&.map(&:id)
      self.save
    end
  end
end
