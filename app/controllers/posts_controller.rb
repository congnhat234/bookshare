class PostsController < ApplicationController
  before_action :find_post, only: %i(show edit update)
  def index
    @posts = Post.page(params[:page]).per Settings.posts.per_page
  end

  def show
  end

  private

  def find_post
    @post = Post.find_by(id: params[:id])
    return if @post
    flash[:danger] = "Not found"
    redirect_to posts_path
  end
end
