class ChangeColumnDefaultForBooks < ActiveRecord::Migration[5.1]
  def change
    change_column_default :books, :price, 0
    change_column_default :books, :quantity, 1
  end
end
