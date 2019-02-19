class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.decimal :total_price, precision: 12, scale: 2, default: 0
      t.string :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
