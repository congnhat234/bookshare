class Post < ApplicationRecord
  belongs_to :user
  has_many :liked_posts, foreign_key: "post_id", dependent: :destroy
  has_many :users, through: :liked_posts
  has_many :comments, dependent: :destroy

  mount_uploader :photo, PhotoUploader

  validates :title, presence: true, length: {minimum: 3, maximum: 100}

  enum status: [:unpublish, :publish]

  scope :order_desc, ->{order created_at: :desc}

  def to_param
    "#{id}-#{title.parameterize}"
  end
end
