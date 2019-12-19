class CategoriesController < ApplicationController
  def show
    @books = case params[:type]
             when "selling"
               Book.selling.where(category_id: params[:id])
                   .page(params[:page]).per Settings.books.per_page
             when "sharing"
               Book.sharing.where(category_id: params[:id])
                   .page(params[:page]).per Settings.books.per_page
             when "exchange"
               Book.exchange.where(category_id: params[:id])
                   .page(params[:page]).per Settings.books.per_page
             else
               Book.where(category_id: params[:id])
                   .page(params[:page]).per Settings.books.per_page
             end
    @type = params[:type] || "all"
    @title = t "books.title.#{@type}"
    render "books/index"
  end
end
