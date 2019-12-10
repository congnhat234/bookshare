module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_manager
      logger.add_tags "ActionCable", current_user.email
    end

    protected

    def find_verified_manager
      verified_user = env["warden"].user :user
      return verified_user if verified_user
      reject_unauthorized_connection
    rescue StandardError
      reject_unauthorized_connection
    end
  end
end
