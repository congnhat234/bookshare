class Order < ApplicationRecord
  has_many :order_books, dependent: :destroy
  has_many :books, through: :order_books
  belongs_to :user

  enum status: [:pending, :processing, :completed, :canceled]
  enum payment_method: [:cod, :bank_transfer, :paypal]

  validates :receiver_name, presence: true
  validates :receiver_address, presence: true
  validates :receiver_phone, presence: true
end
