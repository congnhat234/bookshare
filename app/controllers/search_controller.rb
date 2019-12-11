class SearchController < ApplicationController
  def index
    @books = Book.activated.search params[:q],
      fields: ["title^10", "description", "brief_description", "category_name"],
      operator: "or",
      page: params[:page], per_page: Settings.books.per_page
    @title = t "books.title.all"
    @type = "all"
    render "books/index"
  end

  def index_post
    @posts = Post.publish.search params[:q],
      fields: ["title^10", "content^5", "preview"],
      operator: "or",
      page: params[:page], per_page: Settings.books.per_page
    if user_signed_in?
      recommendable_posts_redis = current_user.recommended_posts
                                              .where.not(user_id: current_user.id)
      @recommendable_posts = recommendable_posts_redis || current_user.recommend_posts
    end
    render "posts/index"
  end
end
