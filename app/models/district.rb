class District < ApplicationRecord
  has_many :wards, dependent: :destroy
  belongs_to :province
end
