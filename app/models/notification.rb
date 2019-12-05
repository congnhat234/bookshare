class Notification < PublicActivity::Activity
  attr_accessor :type, :message

  before_save :set_param_message
  after_create_commit :send_notification

  scope :list_notifications, (lambda do |recipient|
    where recipient: recipient
  end)
  scope :unread, ->{where read: false}
  scope :order_desc, ->{order created_at: :desc}
  scope :marked_read_all, (lambda do
    update_all read: true
  end)

  def json_data
    {
      notification_id: id,
      type_notification: trackable_type,
      status_read: read,
      time: I18n.l(created_at.to_date),
      content: parameters[:message],
      book_id: parameters[:book_id]
    }
  end

  def marked_read
    update_column :read, true
  end

  private

  def send_notification
    channel = recipient.id
    ActionCable.server.broadcast "notifications_#{channel}_channel",
      content: render_notification,
      counter: self.class.list_notifications(recipient).unread.size,
      type: type,
      message: message,
      id: id,
      owner_id: owner_id,
      recipient_id: recipient_id
  end

  def render_notification
    dir = key.split "."
    I18n.with_locale(recipient.locale) do
      ApplicationController.renderer.render partial: "public_activity/#{dir[0]}/#{dir[1]}",
        locals: {
          activity: self
        }
    end
  end

  def set_param_message
    parameters[:message] = message if message
  end
end
