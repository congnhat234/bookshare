class CategoriesController < ApplicationController
  def show
    @books = Book.where(category_id: params[:id].to_i).page(params[:page]).per Settings.books.per_page
    render "books/index"
  end
end
