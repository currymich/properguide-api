class AddColumnToOrderItem < ActiveRecord::Migration[5.0]
  def change
    add_column :order_items, :alt_image, :string
  end
end
