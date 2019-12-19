class Category < ApplicationRecord
  has_many :books, dependent: :destroy
  has_many :child_categories, class_name: Category.name,
    foreign_key: :parent_id, dependent: :destroy
  belongs_to :parent_category, class_name: Category.name,
    foreign_key: :parent_id

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
