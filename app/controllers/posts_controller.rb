class PostsController < ApplicationController
  before_action :find_post, except: %i(index new create user_posts)
  def index
    @posts = Post.publish.order("updated_at DESC").page(params[:page]).per Settings.posts.per_page
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.new post_params
    if @post.save
      flash[:info] = t "alert.success[add_post]"
      redirect_to user_posts_path(current_user)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update_attributes! post_params
      flash[:success] = t "alert.success[update_post]"
      redirect_to user_posts_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = t "alert.success[deleted_post]"
    else
      flash[:danger] = t "alert.error[delete_post]"
    end
    redirect_to user_posts_path(current_user)
  end

  def publish
    if @post.publish!
      flash[:success] = t "alert.success[update_post]"
    else
      flash[:danger] = t "alert.error[update_post]"
    end
    redirect_to user_posts_path(current_user)
  end

  def unpublish
    if @post.unpublish!
      flash[:success] = t "alert.success[update_post]"
    else
      flash[:danger] = t "alert.error[update_post]"
    end
    redirect_to user_posts_path(current_user)
  end

  private

  def find_post
    @post = Post.find_by(id: params[:id])
    return if @post
    flash[:danger] = I18n.t "flash.not_found_post"
    redirect_to posts_path
  end

  def post_params
    params.require(:post).permit :title, :preview, :content, :photo
  end
end
