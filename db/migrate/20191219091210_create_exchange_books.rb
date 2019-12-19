class CreateExchangeBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :exchange_books do |t|
      t.bigint :book_id
      t.integer :quantity, default: 1
      t.bigint :owner_id
      t.bigint :collector_id
      t.timestamps
    end
    add_index :exchange_books, :book_id
    add_index :exchange_books, :collector_id
    add_index :exchange_books, [:book_id, :collector_id], unique: true
  end
end
