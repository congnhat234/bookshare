class AddBriefDescriptionToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :brief_description, :text
  end
end
