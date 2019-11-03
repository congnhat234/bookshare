class AddPhotosToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :photos, :json
  end
end
