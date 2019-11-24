class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :receiver_name
      t.string :receiver_phone
      t.string :receiver_address
      t.float :total_price, default: 0
      t.text :note
      t.integer :status, default: 0
      t.references :user, foreign_key: :true

      t.timestamps
    end
  end
end
