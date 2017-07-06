class UpdatePrecisionForPaymentAmount < ActiveRecord::Migration[5.0]
  def change
    remove_column :payments, :amount, :integer
    add_column :payments, :amount, :decimal, precision: 12, scale: 5
  end
end
