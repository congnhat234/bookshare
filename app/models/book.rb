class Book < ApplicationRecord
  has_many :book_photos, dependent: :destroy
  belongs_to :category
  belongs_to :user

  mount_uploaders :photos, BookPhotoUploader

  enum book_type: [:selling, :exchange, :sharing]

  attr_accessor :total_quantity, :price_discounted

  def get_total_price
    return price_discounted * total_quantity if total_quantity.present?
    price_discounted
  end

  def to_param
    "#{id}-#{title.parameterize}"
  end
end
