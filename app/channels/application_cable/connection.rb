module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :ids

    attr_reader :current_user, :current_user_id, :session_id, :true_user, :true_user_id

    def connect
      @current_user_id = cookies.encrypted[:cuid]
      @true_user_id = cookies.encrypted[:tuid]
      @session_id = cookies.encrypted[:sid]
      @true_user = User.find_by(id: true_user_id) if true_user_id
      @current_user = User.find_by(id: current_user_id) if current_user_id

      self.ids = {
        current_user_id: current_user_id,
        true_user_id: true_user_id,
        session_id: session_id,
      }

      Rails.logger.debug "CONNECT: #{ids.inspect}"
    end
  end
end
