class AddColumnToOrderItems < ActiveRecord::Migration[5.0]
  def change
    add_column :order_items, :unit_name, :string
  end
end
