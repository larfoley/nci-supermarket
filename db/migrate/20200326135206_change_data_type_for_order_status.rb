class ChangeDataTypeForOrderStatus < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      change_table :orders do |t|
        dir.up   { t.change :status, 'integer USING CAST(status AS integer)' }
        dir.down { t.change :status, :string }
      end
    end
  end
end
