class Dashboard::OrdersController < ApplicationController
  before_action :find_order, except: %i(index user_order)
  layout "dashboard/application"

  def index
    @orders = current_user.orders
  end

  def user_order
    order_books = OrderBook.where id: current_user.books.ids
    @orders = Order.where id: order_books.ids
    render :index
  end

  def destroy
    if @order.destroy
      flash[:success] = t "alert.success[delete_order]"
    else
      flash[:danger] = t "alert.error[delete_order]"
    end
    redirect_to dashboard_orders_path
  end

  def processing
    return unless request.xhr?
    if @order.processing!
      render json: {
        status: "processing",
        action: renderhtml_action
      }
    else
      render json: {status: :error}
    end
  end

  def cancel
    return unless request.xhr?
    titles = []
    if @order.canceled!
      @order.order_books.each do |order_book|
        titles << order_book.book.title
      end
      OrderMailer.order_cancel(current_user, @order, titles).deliver_later
      render json: {
        status: "cancel",
        action: renderhtml_action
      }
    else
      render json: {status: :error}
    end
  end

  def done
    return unless request.xhr?
    titles = []
    if @order.completed!
      @order.order_books.each do |order_book|
        titles << order_book.book.title
      end
      OrderMailer.order_done(current_user, @order, titles).deliver_later
      render json: {
        status: "done",
        action: renderhtml_action
      }
    else
      render json: {status: :error}
    end
  end

  private

  def find_order
    @order = Order.find_by(id: params[:id])
    return if @order
    flash.now[:danger] = t "flash.not_found_order"
    redirect_to dashboard_orders_path
  end

  def renderhtml_action
    ApplicationController.render partial: "dashboard/orders/action_btn",
      locals: {order: @order}
  end
end
