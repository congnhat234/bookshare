class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :sender, foreign_key: :sender_id, class_name: "User"
  belongs_to :recipient, foreign_key: :recipient_id, class_name: "User"

  validates :sender_id, uniqueness: {scope: :recipient_id}

  scope :user_conversations, ->(user_id){where(sender_id: user_id).or(where(recipient_id: user_id))}
  scope :sender_unread, ->(user_id){where sender_read: false, sender_id: user_id}
  scope :recipient_unread, ->(user_id){where recipient_read: false, recipient_id: user_id}
  scope :between, (lambda do |sender_id, recipient_id|
                     where(sender_id: sender_id, recipient_id: recipient_id).or(
                       where(sender_id: recipient_id, recipient_id: sender_id)
                     )
                   end)

  def self.get sender_id, recipient_id
    conversation = between(sender_id, recipient_id).first
    return conversation if conversation.present?
    create(sender_id: sender_id, recipient_id: recipient_id)
  end

  def opposed_user user
    user == recipient ? sender : recipient
  end
end
