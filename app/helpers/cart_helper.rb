module CartHelper
  def check_cookie_cart
    return @books_json = Hash.new if cookies[:books].blank?
    @books_json = JSON.parse cookies[:books]
  end

  def update_cookie_cart books_json
    cookies.permanent[:books] = JSON.generate books_json
  end

  def add_book book_id, quantity
    quantity = 1 if quantity.zero?
    check_cookie_cart
    if @books_json.key? book_id
      @books_json[book_id] += quantity
    else
      @books_json[book_id] = quantity
    end
    update_cookie_cart @books_json
  end

  def delete_book book_id
    check_cookie_cart
    return @books_json unless @books_json.key?(book_id)
    @books_json.delete book_id
    update_cookie_cart @books_json
  end

  def update_quantity_book book_id, quantity
    check_cookie_cart
    @books_json[book_id] = quantity
    update_cookie_cart @books_json
  end

  def list_books_cart books_json
    @books = Book.where id: books_json.keys
    @books.each do |book|
      book.total_quantity = books_json[book.id.to_s].to_i
      book.price_discounted = price_discounted book.price, book.discount
    end
  end

  def size_cart
    check_cookie_cart
    @books_json.size
  end

  def price_discounted price, discount
    price - (price * discount / 100)
  end

  def get_cart_total books
    @cart_total = 0
    books.reduce(0) do |sum, book|
      @cart_total = sum + book.get_total_price
    end
  end

  def get_discount_total coupon = nil
    return @discount_total = 0 if coupon.nil?
  end

  def get_grand_total
    @cart_total - @discount_total
  end
end
