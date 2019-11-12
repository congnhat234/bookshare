class Dashboard::SharingBooksController < ApplicationController
  before_action :find_book, :find_sharing_book, except: %i(index request_book)
  layout "dashboard/application"

  def index
    @sharing_books = SharingBook.where(collector: current_user)
  end

  def request_book
    @sharing_books = SharingBook.where(owner: current_user)
    render :index
  end

  def create
    owner = @book.user
    if @sharing_book.nil?
      @sharing_book = SharingBook.new book: @book, owner: owner,
        collector: current_user, quantity: params[:qty]
      status = if @sharing_book.save
                 "success"
               else
                 "fail"
               end
    else
      status = if @sharing_book.update quantity: params[:qty]
                 "success"
               else
                 "fail"
               end
    end
    render json: {status: status}
  end

  def update; end

  def destroy
    redirect_to cart_path
  end

  private

  def find_book
    @book = Book.find_by(id: params[:id])
    return if @book
    flash.now[:danger] = t "flash.not_found_book"
    redirect_back fallback_location: root_path
  end

  def find_sharing_book
    @sharing_book = SharingBook.find_by(book_id: params[:id], collector_id: current_user.id)
  end
end
