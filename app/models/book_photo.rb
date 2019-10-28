class BookPhoto < ApplicationRecord
  belongs_to :book
  mount_uploader :file_name, BookPhotoUploader
end
