class ReviewsController < ApplicationController
  include ReviewsHelper
  before_action :find_review, only: :destroy
  before_action :find_book, only: %i(create destroy)

  def create
    book_id = params[:book_id]
    @review = Review.new book_id: book_id,
      rating: params[:rating], content: params[:content],
      user_id: current_user.id
    Review.transaction do
      @review.save
      load_reviews
      update_rating_and_render
    end
  rescue ActiveRecord::RecordInvalid
    redirect_to book_path id: book_id
  end

  def destroy
    Review.transaction do
      @review.destroy
      load_reviews
      update_rating_and_render
    end
  rescue ActiveRecord::RecordInvalid
    redirect_to book_path id: params[:book_id]
  end

  private

  def load_reviews
    @reviews = Review.where(book_id: params[:book_id])
  end

  def update_rating_and_render
    overall = @reviews.average(:rating).round(1)
    @book.update_attribute :rating, overall
    render json: {
      overall: overall,
      counter_reviews: @reviews.count(:rating),
      review: renderhtml_review
    }
  end

  def renderhtml_review
    ApplicationController.render partial: "books/review", locals: {review: @review}
  end

  def find_review
    @review = Review.find_by id: params[:review_id]
    return if @review
    flash[:danger] = t "helpers.error[review_not_found]"
    redirect_back_or book_path id: params[:book_id]
  end

  def find_book
    @book = Book.activated.find_by id: params[:book_id]
    return if @book
    flash[:danger] = t "helpers.error[book_not_found]"
    redirect_to books_path
  end
end
