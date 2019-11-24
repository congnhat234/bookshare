class CreateOrderBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :order_books do |t|
      t.integer :quantity
      t.float :actual_price
      t.references :book, foreign_key: :true
      t.references :order, foreign_key: :true

      t.timestamps
    end
  end
end
