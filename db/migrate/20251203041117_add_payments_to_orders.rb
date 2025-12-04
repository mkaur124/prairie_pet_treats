class AddPaymentsToOrders < ActiveRecord::Migration[7.1]
  def change

    add_column :orders, :stripe_payment_intent_id, :string
    add_column :orders, :stripe_charge_id, :string
    add_column :orders, :stripe_session_id, :string
    add_column :orders, :order_snapshot, :jsonb, default: {}
  end
end
