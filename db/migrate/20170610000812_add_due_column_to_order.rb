class AddDueColumnToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :due_date, :datetime
  end
end
