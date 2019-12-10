class NotificationsController < ApplicationController
  before_action :load_notification, only: :update
  before_action :page_out_of_range, only: :index

  def index
    notifications = @notifications.map do |notification|
      Object.const_get(notification.parameters[:presenter] ||
        notification.trackable_type + "Presenter").new notification
    end

    @notifications_presenter = Kaminari.paginate_array(notifications).page(params[:page])
                                       .per Settings.notifications.per_page
  end

  def update
    return unless request.xhr? || @notification

    if @notification.update_attributes read: true
      render json: {
        status: :success,
        counter: Notification.list_notifications(current_user).unread.size
      }
    else
      render json: {status: :error}
    end
  end

  def read_all
    @notifications.update_all read: true
    if request.xhr?
      render json: {status: :success}
    else
      flash[:success] = t("flash.messages.mark_all_read")
      redirect_back fallback_location: root_path
    end
  end

  private

  def load_notification
    @notification = @activities.find_by id: params[:id]
    render json: {status: :error} unless @notification
  end

  def page_out_of_range
    return if @notifications.empty? && !params[:page] && current_user.admin?
    return render file: "public/404.html", layout: false if Notification
                                                            .page(params[:page])
                                                            .per(Settings.notifications.per_page)
                                                            .out_of_range?
  end
end
