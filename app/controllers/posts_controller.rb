class PostsController < ApplicationController
  before_action :verify_user, except: %i(index show)
  before_action :find_post, except: %i(index new create user_posts)
  before_action :load_comments, only: :show
  def index
    @posts = Post.publish.order("updated_at DESC")
                 .page(params[:page])
                 .per Settings.posts.per_page
    return @recommendable_posts = Post.publish.order_desc.limit(5) unless user_signed_in?
    recommendable_posts_redis = current_user.recommended_posts
                                            .where.not(user_id: current_user.id)
    @recommendable_posts = if recommendable_posts_redis.any?
                             recommendable_posts_redis
                           else
                             current_user.recommend_posts
                           end
    user_following = current_user.following.ids
    user_following_posts = Post.publish.where(user_id: user_following).order_desc.limit(5)
    @following_posts = if user_following_posts.any?
                         user_following_posts
                       else
                         Post.publish.order_desc.limit(5)
                       end
  end

  def show
    return @recommendable_posts = Post.publish.order_desc.limit(5) unless user_signed_in?
    recommendable_posts_redis = current_user.recommended_posts
                                            .where.not(user_id: current_user.id)
    @recommendable_posts = if recommendable_posts_redis.any?
                             recommendable_posts_redis
                           else
                             current_user.recommend_posts
                           end
    user_following = current_user.following.ids
    user_following_posts = Post.publish.where(user_id: user_following).order_desc.limit(5)
    @following_posts = if user_following_posts.any?
                         user_following_posts
                       else
                         Post.publish.order_desc.limit(5)
                       end
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

  def load_comments
    @comments = @post.comments.where(parent_id: nil).order(:updated_at).reverse
  end
end
