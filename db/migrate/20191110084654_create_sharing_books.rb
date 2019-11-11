class CreateSharingBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :sharing_books do |t|
      t.bigint :book_id
      t.integer :quantity, default: 1
      t.bigint :owner_id
      t.bigint :collector_id
      t.timestamps
    end
    add_index :sharing_books, :book_id
    add_index :sharing_books, :collector_id
    add_index :sharing_books, [:book_id, :collector_id], unique: true
  end
end
