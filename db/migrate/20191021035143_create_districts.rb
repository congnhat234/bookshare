class CreateDistricts < ActiveRecord::Migration[5.1]
  def change
    create_table :districts do |t|
      t.string :name
      t.string :prefix
      t.references :province, foreign_key: true
    end
  end
end
