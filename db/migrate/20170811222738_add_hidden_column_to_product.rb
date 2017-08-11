class AddHiddenColumnToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :hidden, :boolean
  end
end
