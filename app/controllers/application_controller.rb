class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery with: :exception
  before_action :load_categories
  before_action :set_locale
  before_action :load_notifications

  private

  def load_categories
    @categories = Category.order(:name)
  end

  def set_locale
    locale = cookies[:language].to_s.strip.to_sym
    I18n.locale = if I18n.available_locales.include?(locale)
                    locale
                  else
                    I18n.default_locale
                  end
  end

  def load_notifications
    return unless user_signed_in?
    @counter = Notification.list_notifications(current_user).unread.size
    @inbox_counter = Conversation.user_conversations(current_user.id).sender_unread(current_user.id).count
    @inbox_counter += Conversation.user_conversations(current_user.id).recipient_unread(current_user.id).count
    @request_sharing_books_counter = SharingBook.where(owner: current_user).except_notconfirm.count
    @activities = Notification.list_notifications(current_user)
                              .limit(4).order_desc
  end
end
