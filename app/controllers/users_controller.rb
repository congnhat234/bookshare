class UsersController < ApplicationController
  before_action :verify_user, only: :index
  before_action :find_user, only: %i(show posts books)
  before_action :authenticate_user!, only: %i(index)
  layout "dashboard/application", only: %i(index)

  def index
  end

  def show
    @books = @user.books.order_desc.limit Settings.books.per_page
  end

  def posts
    @posts = @user.posts.order_desc.page(params[:page]).per Settings.posts.per_page
    render "posts/index"
  end

  def books
    @books = @user.books.order_desc.page(params[:page]).per Settings.books.per_page
    render "books/index"
  end

  private

  def find_user
    @user = User.friendly.find(params[:id])
    return if @user && @user.confirmed?
    flash[:danger] = I18n.t "flash.not_found_user"
    redirect_to root_path
  end
end
