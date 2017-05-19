class AddAndRemoveReferenceFromOrders < ActiveRecord::Migration[5.0]
  def change
    remove_reference :orders, :user
    add_reference :orders, :dentist, foreign_key: true
  end
end
