class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.float :total_price, default: 0
      t.string :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
