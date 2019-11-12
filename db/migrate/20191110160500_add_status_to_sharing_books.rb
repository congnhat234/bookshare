class AddStatusToSharingBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :sharing_books, :status, :integer, default: 0
  end
end
