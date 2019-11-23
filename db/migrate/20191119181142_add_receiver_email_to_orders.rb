class AddReceiverEmailToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :receiver_email, :string
  end
end
