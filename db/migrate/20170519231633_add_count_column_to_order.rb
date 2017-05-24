class AddCountColumnToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :count, :integer
  end
end
