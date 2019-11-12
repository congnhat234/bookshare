class User < ApplicationRecord
  include FriendlyIdHash
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :confirmable, :lockable, :timeoutable, :trackable, :omniauthable

  has_many :books, dependent: :destroy
  has_many :posts, dependent: :destroy

  mount_uploader :avatar, PhotoUploader

  validates_with PasswordValidator

  enum role: [:normal_user, :charity_organization, :seller]
end
