class SharingBook < ApplicationRecord
  belongs_to :book
  belongs_to :owner, class_name: "User"
  belongs_to :collector, class_name: "User"
  validates :owner_id, presence: true
  validates :collector_id, presence: true
  validates :book_id, presence: true

  enum status: [:notconfirm, :inprogress, :approved, :rejected, :done]

  scope :except_notconfirm, ->{where.not status: 0}
end
