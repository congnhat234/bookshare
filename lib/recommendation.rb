module Recommendation
  def recommend_posts
    other_users = self.class.all.where.not(id: id)
    recommended = Hash.new(0)
    recommendable_posts = []
    other_users.each do |user|
      common_posts = user.l_posts & l_posts
      weight = common_posts.size.to_f / user.l_posts.size
      (user.l_posts - common_posts).each do |post|
        recommended[post] += weight
      end
    end
    sorted_recommended = recommended.sort_by{|_key, value| value}.reverse
    sorted_recommended.map do |key, _value|
      recommendable_posts << key if key.user_id != id
    end
    recommendable_posts
  end
end
