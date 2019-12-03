class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :child_comments, dependent: :destroy,
    class_name: Comment.name, foreign_key: :parent_id
end
