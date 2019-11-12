class UsersController < ApplicationController
  before_action :find_user, only: %i(show posts)

  def show
  end

  def posts
    @posts = @user.posts.page(params[:page]).per Settings.posts.per_page
    render "posts/index"
  end

  private

  def find_user
    @user = User.friendly.find(params[:id])
    return if @user && @user.confirmed?
    flash[:danger] = I18n.t "flash.not_found_user"
    redirect_to root_path
  end
end
