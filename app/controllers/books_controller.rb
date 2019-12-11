class BooksController < ApplicationController
  before_action :find_book, only: %i(show)
  before_action :load_reviews, only: %i(show)

  def index
    @books = Book.activated.page(params[:page]).per Settings.books.per_page
    @title = t "books.title.all"
    @type = "all"
  end

  def show
    @related_books = Book.activated.where(category: @book.category).order_desc.limit(10)
    last_book = Book.find_by(id: cookies[:recent_book] || @book.id)
    @recommended_books = Book.except_current_book(@book.id).activated.except_current_book(@book.id).search(last_book.title,
      fields: ["title^10", "description", "brief_description", "category_name"],
      operator: "or")
    cookies[:recent_book] = @book.id
  end

  def selling
    @books = Book.activated.selling.page(params[:page]).per Settings.books.per_page
    @title = t "books.title.selling"
    @type = "selling"
    render :index
  end

  def sharing
    @books = Book.activated.sharing.page(params[:page]).per Settings.books.per_page
    @title = t "books.title.sharing"
    @type = "sharing"
    render :index
  end

  def exchange
    @books = Book.activated.exchange.page(params[:page]).per Settings.books.per_page
    @title = t "books.title.exchange"
    @type = "exchange"
    render :index
  end

  private

  def find_book
    @book = Book.activated.find_by(id: params[:id])
    return if @book
    flash.now[:danger] = "Not found"
    redirect_to books_path
  end

  def load_reviews
    @reviews = @book.reviews.order(:updated_at).reverse
  end
end
