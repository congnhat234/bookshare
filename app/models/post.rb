class Post < ApplicationRecord
  belongs_to :user

  mount_uploader :photo, PhotoUploader

  validates :title, presence: true, length: {minimum: 10, maximum: 100}

  enum status: [:unpublish, :publish]

  def to_param
    "#{id}-#{title.parameterize}"
  end
end
