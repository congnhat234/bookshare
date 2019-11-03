class CreateBookPhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :book_photos do |t|
      t.string :file_name
      t.references :book, foreign_key: :true
      t.timestamps
    end
  end
end
