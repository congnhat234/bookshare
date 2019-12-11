class Admins::BooksController < ApplicationController
  before_action :find_book, only: %i(destroy active inactive)
  layout "admins/application"

  def index
    @books = case params[:type]
             when "selling"
               @type = "selling"
               Book.selling
             when "sharing"
               @type = "sharing"
               Book.sharing
             when "exchange"
               @type = "exchange"
               Book.exchange
             else
               @type = "all"
               Book.all
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

  def active
    return unless request.xhr?
    if @book.update_attributes! activated: false
      render json: {
        status: renderhtml_status("active")
      }
    else
      render json: {status: :error}
    end
  end

  def inactive
    return unless request.xhr?
    if @book.update_attributes! activated: false
      render json: {
        status: renderhtml_status("inactive")
      }
    else
      render json: {status: :error}
    end
  end

  private

  def find_book
    @book = Book.find_by(id: params[:id])
    return if @book
    flash.now[:danger] = t "flash.not_found_book"
    redirect_to dashboard_books_path
  end

  def renderhtml_status status
    if status == "active"
      ApplicationController.render partial: "admins/books/active",
        locals: {book_id: @book.id}
    elsif status == "inactive"
      ApplicationController.render partial: "admins/books/inactive",
        locals: {book_id: @book.id}
    end
  end
end
