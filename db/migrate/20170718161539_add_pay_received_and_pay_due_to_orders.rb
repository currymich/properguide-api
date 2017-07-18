class AddPayReceivedAndPayDueToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :pay_received, :decimal, precision: 12, scale: 5
    add_column :orders, :pay_due, :decimal, precision: 12, scale: 5
  end
end
