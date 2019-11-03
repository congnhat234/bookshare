class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.float :price
      t.integer :quantity, default: 0
      t.float :rating, default: 0
      t.integer :view, default: 0
      t.text :description
      t.float :discount, default: 0
      t.integer :book_type
      t.boolean :activated, default: true
      t.references :category, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
