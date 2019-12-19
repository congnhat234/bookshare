class OrdersController < ApplicationController
  before_action :verify_user
  include CartHelper

  before_action :find_order, only: :show

  def show; end

  def new
    list_books_cart check_cookie_cart
    return @order = Order.new if @books.any?
    flash[:danger] = t "helpers.info[access_denied]"
    redirect_to cart_index_path
  end

  def create
    list_books_cart check_cookie_cart
    @orders = []
    @owners = []
    @books.each do |book|
      next if @owners.include? book.user.id
      order = current_user.orders.new order_params
      @orders << order
      @owners << book.user.id
    end

    Order.transaction do
      @orders.each_with_index do |order, index|
        order.save
        save_book_order @books, order, index
      end
      cookies.delete :books
      flash[:info] = t "helpers.info[order_success]"
      redirect_to order_path(@orders[0])
    end
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = t "helpers.error[order_fail]"
    render :new
  end

  private

  def order_params
    params.require(:order).permit :receiver_name, :receiver_phone,
      :receiver_address, :receiver_email, :payment_method, :note, :total_price
  end

  def save_book_order books, order, index
    titles = []
    order_total = 0
    books.each do |book|
      next unless book.user.id == @owners[index]
      books_order = order.order_books.new(book_id: book.id,
        quantity: book.total_quantity, actual_price: book.price_discounted)
      books_order.save
      current_user.like(book)
      titles << book.title
      order_total += book.price_discounted
    end
    order.update! total_price: order_total
    OrderMailer.order_complete(current_user, order, titles).deliver_later
  end

  def find_order
    @order = Order.find_by(id: params[:id])
    return if @order
    flash[:danger] = t "helpers.error[order_not_found]"
    redirect_to cart_path
  end
end
