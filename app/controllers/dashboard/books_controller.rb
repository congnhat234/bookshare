class Dashboard::BooksController < ApplicationController
  before_action :verify_user
  before_action :find_book, only: %i(edit update destroy)
  layout "dashboard/application"

  def index
    @books = current_user.books
  end

  def new
    @book = current_user.books.build
  end

  def create
    @book = current_user.books.new book_params
    if @book.save
      flash[:info] = t "alert.success[add_book]"
      redirect_to dashboard_books_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @book.update_attributes! book_params
      flash[:success] = t "alert.success[update_book]"
      redirect_to dashboard_books_path
    else
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t "alert.success[delete_book]"
    else
      flash[:danger] = t "alert.error[delete_book]"
    end
    redirect_to dashboard_books_path
  end

  private

  def find_book
    @book = Book.find_by(id: params[:id])
    return if @book
    flash.now[:danger] = t "flash.not_found_book"
    redirect_to dashboard_books_path
  end

  def book_params
    params.require(:book).permit :title, :price, :quantity, :discount,
      :brief_description, :description, :book_type, :category_id, photos: []
  end
end
