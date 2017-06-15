class AddTaxColumnToDentist < ActiveRecord::Migration[5.0]
  def change
    add_column :dentists, :tax, :decimal, precision: 12, scale: 3
  end
end
