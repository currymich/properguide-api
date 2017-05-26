class AddOrderStatusAndDentistNameToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :dentist_name, :string
    add_column :orders, :order_status, :string
  end
end
