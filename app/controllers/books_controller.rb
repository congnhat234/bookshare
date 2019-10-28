class BooksController < ApplicationController
  before_action :find_book, only: %i(show edit update)
  def index
    @books = Book.page(params[:page]).per Settings.books.per_page
  end

  def show
  end

  private

  def find_book
    @book = Book.find_by(id: params[:id])
  end
end
