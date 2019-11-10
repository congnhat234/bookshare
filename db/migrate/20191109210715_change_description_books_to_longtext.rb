class ChangeDescriptionBooksToLongtext < ActiveRecord::Migration[5.1]
  def change
    change_column :books, :description, :longtext
  end
end
