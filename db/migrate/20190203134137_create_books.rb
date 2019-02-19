class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :name
      t.decimal :price, precision: 12, scale: 2
      t.text :description
      t.integer :publication_year
      t.float :height
      t.float :width
      t.float :depth
      t.string :material

      t.timestamps
    end
  end
end
