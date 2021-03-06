require "./lib/recommendation.rb"

class User < ApplicationRecord
  include FriendlyIdHash
  include Recommendation
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :confirmable, :lockable, :timeoutable, :trackable, :omniauthable

  has_many :books, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :sharing_books
  has_many :exchange_books

  has_many :liked_posts, foreign_key: "user_id", dependent: :destroy
  has_many :l_posts, through: :liked_posts, source: :post

  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :messages
  has_many :conversations, foreign_key: :sender_id

  before_save :downcase_email

  mount_uploader :avatar, PhotoUploader

  validates_with PasswordValidator

  enum role: [:normal_user, :charity_organization, :seller]

  scope :order_desc, ->{order created_at: :desc}
  scope :other_comment_users, (lambda do |post, owner|
    joins(:comments).where(comments: {post_id: post.id})
                    .where.not(comments: {user_id: owner.id})
  end)

  # scope :review_users, (lambda do |book, owner|
  #   joins(:reviews).where(reviews: {book_id: book.id})
  #                   .where.not(reviews: {user_id: owner.id})
  # end)

  recommends :posts, :books

  def follow other_user
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  def liked_post? post
    l_posts.include? post
  end

  def like_post post
    liked_posts.create post_id: post.id
  end

  def unlike_post post
    l_posts.delete post
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
