class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :country
      t.string :city
      t.string :address
      t.string :zip
      t.string :phone
      t.integer :cast

      t.timestamps
    end
  end
end
