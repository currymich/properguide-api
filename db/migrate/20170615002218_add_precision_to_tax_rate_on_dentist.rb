class AddPrecisionToTaxRateOnDentist < ActiveRecord::Migration[5.0]
  def change
    remove_column :dentists, :tax, :decimal
    add_column :dentists, :tax_rate, :decimal, precision: 12, scale: 5 
  end
end
