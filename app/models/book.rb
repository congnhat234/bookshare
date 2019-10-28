class Book < ApplicationRecord
  has_many :book_photos, dependent: :destroy
  belongs_to :category
  belongs_to :user

  mount_uploaders :photos, BookPhotoUploader
end
