class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :child_comments, dependent: :destroy,
    class_name: Comment.name, foreign_key: :parent_id

  after_save :make_notification

  def make_notification
    unless user.id == post.user.id
      Notification.create trackable: self, owner: user,
        recipient: post.user,
        key: "comment.create", type: :comment_create,
        parameters: {post_id: post.id},
        message: I18n.t("public_activity.comment.create.message",
          owner: user.name,
          locale: post.user.locale)
    end
    User.other_comment_users(post, user).group(:id).each do |realated_user|
      Notification.create trackable: self, owner: user,
        recipient: realated_user,
        key: "comment.create_interested", type: :comment_create,
        parameters: {post_id: post.id},
        message: I18n.t("public_activity.comment.create_interested.message",
          owner: user.name,
          locale: realated_user.locale)
    end
  end
end
