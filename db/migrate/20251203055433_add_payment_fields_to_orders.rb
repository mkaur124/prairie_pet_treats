class AddPaymentFieldsToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :paid, :boolean
    add_column :orders, :payment_id, :string
  end
end
