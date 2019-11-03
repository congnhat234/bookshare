class Category < ApplicationRecord
  has_many :books, dependent: :destroy

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
