class StaticPagesController < ApplicationController
  def home
    @new_books = Book.activated.order_desc.limit(10)
    best_seller_ids = Hash[OrderBook.group(:book_id).limit(10).count.sort_by{|_k, v| v}.reverse].keys
    best_seller_books = Book.where(id: best_seller_ids).index_by(&:id)
    @best_seller_books = best_seller_ids.map{|id| best_seller_books[id]}
    random_books = if Rails.env == "development"
                     Book.activated.sample(10)
                   else
                     Book.activated.order("RANDOM()").limit(10)
                   end
    if user_signed_in?
      recommendable_books_redis = current_user.recommended_books
                                              .where.not(user_id: current_user.id)
      @recommendable_books = if recommendable_books_redis.any?
                               recommendable_books_redis
                             else
                               random_books
                             end
      user_following = current_user.following.ids
      user_following_posts = Post.publish.where(user_id: user_following).order_desc.limit(3)
      @posts = if user_following_posts.any?
                 user_following_posts
               else
                 Post.publish.order_desc.limit(3)
               end
    else
      @recommendable_books = random_books
      @posts = Post.publish.order_desc.limit(3)
    end
  end

  def set_language
    store_location
    cookies.permanent[:language] = params[:locale]
    current_user.update(locale: params[:locale]) if user_signed_in?
    redirect_back fallback_location: root_path
  end
end
