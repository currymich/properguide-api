class AddExtraFeeFieldToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :extra_fee, :boolean
  end
end
