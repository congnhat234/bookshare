class Admin < ApplicationRecord
  devise :database_authenticatable,
    :recoverable, :validatable,
    :trackable, :timeoutable, timeout_in: Settings.timeoutable.timeout.minutes
  validates_with PasswordValidator

  mount_uploader :avatar, PhotoUploader
end
