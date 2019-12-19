class LikedPostsController < ApplicationController
  before_action :verify_user
  before_action :find_post, only: %i(create)
  before_action :find_liked_post, only: %i(destroy)

  def create
    current_user.like_post @post
    current_user.like(@post)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @post = @liked_post.post
    current_user.unlike_post @post
    current_user.unlike(@post)
    respond_to do |format|
      format.js
    end
  end

  private

  def find_post
    @post = Post.find_by id: params[:post_id]
    return if @post&.publish?
    flash[:danger] = t "helpers.error[post_not_found]"
    redirect_to root_url
  end

  def find_liked_post
    @liked_post = LikedPost.find params[:id]
    return if @liked_post
    flash[:danger] = t "helpers.error[liked_post_not_found]"
    redirect_to root_url
  end
end
