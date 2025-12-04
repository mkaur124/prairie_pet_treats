class AddStatusIntToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :status_int, :integer, default: 0, null: false
  end
end
