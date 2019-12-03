class Post < ApplicationRecord
  searchkick

  belongs_to :user
  has_many :liked_posts, foreign_key: "post_id", dependent: :destroy
  has_many :users, through: :liked_posts
  has_many :comments, dependent: :destroy

  mount_uploader :photo, PhotoUploader

  validates :title, presence: true, length: {minimum: 10, maximum: 100}

  enum status: [:unpublish, :publish]

  def to_param
    "#{id}-#{title.parameterize}"
  end

  def search_data
    {
      title: title,
      content: content,
      preview: preview
    }
  end
end
