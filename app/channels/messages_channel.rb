class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages_#{current_user.id}_channel"
  end

  def unsubscribed
    stop_all_streams
  end
end
