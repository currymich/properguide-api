class AddNotesColumnToDentist < ActiveRecord::Migration[5.0]
  def change
    add_column :dentists, :notes, :string
  end
end
