class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :status
      t.decimal :total
      t.string :delivery_address

      t.timestamps
    end
  end
end
