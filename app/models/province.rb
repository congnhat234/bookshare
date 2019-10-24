class Province < ApplicationRecord
  has_many :districts, dependent: :destroy
  has_many :wards, dependent: :destroy
end
