class CartController < ApplicationController
  include CartHelper

  def index
    list_books_cart check_cookie_cart
  end

  def add
    add_book params[:book_id], params[:qty].to_i
    render json: {size_cart: size_cart}
  end

  def remove
    delete_book params[:id]
    redirect_to cart_path
  end

  def update
    book_id = params[:id]
    quantity = params[:quantity].to_i
    update_quantity_book book_id, quantity
    list_books_cart check_cookie_cart
    book = @books.find{|b| b.id == book_id.to_i}
    get_discount_total
    render json: {
      total_quantity: quantity,
      total_price: number_to_currency_format(book.get_total_price),
      cart_total: number_to_currency_format(get_cart_total(@books)),
      grand_total: number_to_currency_format(get_grand_total)
    }
  end
end
