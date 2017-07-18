class AddTaxExemptOptionToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :tax_exempt, :boolean
  end
end
