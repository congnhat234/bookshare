class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :confirmable, :lockable, :timeoutable, :trackable, :omniauthable
  validates_with PasswordValidator

  has_many :books, dependent: :destroy
  has_many :posts, dependent: :destroy
end
