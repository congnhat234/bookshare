class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  after_create_commit :send_notification

  validates :body, presence: true

  private

  def send_notification
    channel = conversation.opposed_user(user).id
    counter = if user == conversation.sender
                conversation.update_attributes(recipient_read: false)
                Conversation.user_conversations(user.id).sender_unread(user.id).size
              else
                conversation.update_attributes(sender_read: false)
                Conversation.user_conversations(user.id).recipient_unread(user.id).size
              end
    ActionCable.server.broadcast "messages_#{channel}_channel",
      body: render_notification,
      counter: counter,
      id: conversation.id,
      sender_id: conversation.sender.id,
      recipient_id: conversation.recipient.id
  end

  def render_notification
    ApplicationController.renderer.render partial: "dashboard/messages/message",
      locals: {
        message: self,
        current_user: conversation.opposed_user(user)
      }
  end
end
