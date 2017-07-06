class RenameReferenceOnPayments < ActiveRecord::Migration[5.0]
  def change
    remove_reference :payments, :orders
    add_reference :payments, :order, foreign_key: true
  end
end
