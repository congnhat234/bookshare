class Dashboard::OrdersController < ApplicationController
  layout "dashboard/application"

  def index
    @orders = current_user.orders
  end

  def user_order
    order_books = OrderBook.where id: current_user.books.ids
    @orders = Order.where id: order_books.ids
    render :index
  end
end
