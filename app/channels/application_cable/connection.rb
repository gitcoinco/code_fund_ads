# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :example_id

    def connect
      example_id = cookies.encrypted[:example_id]
      return reject_unauthorized_connection if example_id.nil?
      self.example_id = example_id
    end
  end
end
