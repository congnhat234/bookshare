class Admins::PostsController < ApplicationController
  before_action :find_post, only: %i(edit update destroy publish unpublish)
  layout "admins/application"

  def index
    @posts = Post.all.order_desc
  end

  def edit; end

  def update
    if @post.update_attributes! post_params
      flash[:success] = t "alert.success[update_post]"
      redirect_to admins_posts_path
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = t "alert.success[delete_post]"
    else
      flash[:danger] = t "alert.error[delete_post]"
    end
    redirect_to admins_posts_path
  end

  def publish
    return unless request.xhr? || @notification
    if @post.publish!
      CLASSIFIER_POST.train "Good", @post.title
      render json: {
        status: renderhtml_status("publish")
      }
    else
      render json: {status: :error}
    end
  end

  def unpublish
    return unless request.xhr? || @notification
    if @post.unpublish!
      CLASSIFIER_POST.train "Spam", @post.title
      render json: {
        status: renderhtml_status("unpublish")
      }
    else
      render json: {status: :error}
    end
  end

  def auto_classify
    @posts = Post.publish
    counter = 0
    @posts.each do |post|
      if CLASSIFIER_POST.classify(post.title) == "Spam"
        post.unpublish!
        counter += 1
      end
    end
    cookies[:spam_counter] = counter
    redirect_to admins_posts_path
  end

  private

  def find_post
    @post = Post.find_by(id: params[:id])
    return if @post
    flash.now[:danger] = t "flash.not_found_post"
    redirect_to admins_posts_path
  end

  def post_params
    params.require(:post).permit :title, :preview, :content, :photo
  end

  def renderhtml_status status
    if status == "publish"
      ApplicationController.render partial: "admins/posts/publish",
        locals: {post_id: @post.id}
    elsif status == "unpublish"
      ApplicationController.render partial: "admins/posts/unpublish",
        locals: {post_id: @post.id}
    end
  end
end
