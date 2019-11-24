class CreateLikedPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :liked_posts do |t|
      t.bigint :user_id
      t.bigint :post_id

      t.timestamps
    end
    add_index :liked_posts, :user_id
    add_index :liked_posts, :post_id
    add_index :liked_posts, [:user_id, :post_id], unique: true
  end
end
