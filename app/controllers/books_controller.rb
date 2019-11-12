class BooksController < ApplicationController
  before_action :find_book, only: %i(show)

  def index
    @books = Book.page(params[:page]).per Settings.books.per_page
    @title = t "books.title.all"
    @type = "all"
  end

  def show
  end

  def selling
    @books = Book.selling.page(params[:page]).per Settings.books.per_page
    @title = t "books.title.selling"
    @type = "selling"
    render :index
  end

  def sharing
    @books = Book.sharing.page(params[:page]).per Settings.books.per_page
    @title = t "books.title.sharing"
    @type = "sharing"
    render :index
  end

  def exchange
    @books = Book.exchange.page(params[:page]).per Settings.books.per_page
    @title = t "books.title.exchange"
    @type = "exchange"
    render :index
  end

  private

  def find_book
    @book = Book.find_by(id: params[:id])
    return if @book
    flash.now[:danger] = "Not found"
    redirect_to books_path
  end
end
