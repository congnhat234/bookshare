class Dashboard::ExchangeBooksController < ApplicationController
  before_action :find_book, :find_exchange_book, only: %i(create)
  before_action :find_exchange_book_by_id, only: %i(destroy confirm approve reject done)
  layout "dashboard/application"

  def index
    @exchange_books = ExchangeBook.where(collector: current_user)
  end

  def request_book
    @exchange_books = ExchangeBook.where(owner: current_user).inprogress
    render :index
  end

  def create
    owner = @book.user
    if @exchange_book.nil?
      @exchange_book = ExchangeBook.new book: @book, owner: owner,
        collector: current_user, quantity: params[:qty]
      status = if @exchange_book.save
                 "success"
               else
                 "fail"
               end
    else
      status = if @exchange_book.update quantity: params[:qty]
                 "success"
               else
                 "fail"
               end
    end
    current_user.like(@book)
    render json: {status: status}
  end

  def update; end

  def destroy
    if @exchange_book.destroy
      flash[:success] = t "alert.success[delete_book]"
    else
      flash[:danger] = t "alert.error[delete_book]"
    end
    redirect_to dashboard_books_path
  end

  def confirm
    return unless request.xhr?
    if @exchange_book.inprogress!
      render json: {
        status: "inprogress",
        action: renderhtml_action("index")
      }
    else
      render json: {status: :error}
    end
  end

  def done
    return unless request.xhr?
    if @exchange_book.done!
      render json: {
        status: "done",
        action: renderhtml_action("request_book")
      }
    else
      render json: {status: :error}
    end
  end

  def approve
    return unless request.xhr?
    if @exchange_book.approved!
      render json: {
        status: "approved",
        action: renderhtml_action("request_book")
      }
    else
      render json: {status: :error}
    end
  end

  def reject
    return unless request.xhr?
    if @exchange_book.rejected!
      render json: {
        status: "rejected",
        action: renderhtml_action("request_book")
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
    redirect_back fallback_location: root_path
  end

  def find_exchange_book
    @exchange_book = ExchangeBook.find_by(book_id: params[:id], collector_id: current_user.id)
  end

  def find_exchange_book_by_id
    @exchange_book = ExchangeBook.find_by(id: params[:id])
  end

  def renderhtml_action action_name
    ApplicationController.render partial: "dashboard/exchange_books/action_btn",
      locals: {exchange_book: @exchange_book, action_name: action_name}
  end
end
