class AddImgColumnToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :alt_image, :string
  end
end
