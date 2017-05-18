class AddImgColumnToOrderItems < ActiveRecord::Migration[5.0]
  def change
    add_column :order_items, :image_url, :string
  end
end
