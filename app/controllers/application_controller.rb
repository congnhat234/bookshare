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
    @request_sharing_books_counter = SharingBook.where(owner: current_user).inprogress.count
    @request_exchange_books_counter = ExchangeBook.where(owner: current_user).inprogress.count
    @activities = Notification.list_notifications(current_user).order_desc
  end

  def verify_admin
    return if admin_signed_in?
    flash[:danger] = t "alert.error[access_denied]"
    redirect_to new_admin_session_path
  end

  def verify_user
    return if user_signed_in?
    flash[:danger] = t "alert.error[sign_in]"
    redirect_to new_user_session_path
  end
end
