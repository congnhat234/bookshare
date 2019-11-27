class Book < ApplicationRecord
  has_many :book_photos, dependent: :destroy
  has_many :sharing_books, dependent: :destroy
  has_many :order_books, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :category
  belongs_to :user

  mount_uploaders :photos, BookPhotoUploader

  enum book_type: [:selling, :exchange, :sharing]

  attr_accessor :total_quantity, :price_discounted

  scope :activated, ->{where activated: true}

  def get_total_price
    return (price_discounted * total_quantity).round if total_quantity.present?
    price_discounted.round
  end

  def to_param
    "#{id}-#{title.parameterize}"
  end
end
