module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :cable_id

    def connect
      cable_id = cookies.encrypted[:cable_id]
      return reject_unauthorized_connection if cable_id.nil?
      self.cable_id = cable_id
    end
  end
end
