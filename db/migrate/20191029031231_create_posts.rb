class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :preview
      t.text :content
      t.integer :view, default: 0
      t.string :photo
      t.references :user, foreign_key: :true
      t.timestamps
    end
  end
end
