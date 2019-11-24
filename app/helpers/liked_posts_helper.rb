module LikedPostsHelper
  def find_liked_post
    current_user.liked_posts.find_by(post_id: @post.id)
  end
end
