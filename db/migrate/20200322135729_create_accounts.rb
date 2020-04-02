class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :delivery_address

      t.timestamps
    end
  end
end
