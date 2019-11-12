class UsersController < ApplicationController
  def show
  end

  def posts
    return redirect_to new_user_session_path unless user_signed_in?
    user = User.friendly.find(params[:id])
    @posts = user.posts.page(params[:page]).per Settings.posts.per_page
    render "posts/index"
  end
end
