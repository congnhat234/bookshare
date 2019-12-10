class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  after_save :make_notification

  def make_notification
    return if user.id == book.user.id
    message = I18n.t("public_activity.review.create.message",
      owner: user.name,
      locale: book.user.locale)
    Notification.create trackable: self, owner: user, recipient: book.user,
      key: "review.create", type: :review_create,
      parameters: {book_id: book.id},
      message: message
  end
end
