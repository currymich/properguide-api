class RemoveNotesColumnFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :notes, :string
  end
end
