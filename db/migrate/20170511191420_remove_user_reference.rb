class RemoveUserReference < ActiveRecord::Migration[5.0]
  def change
    remove_reference :questions, :user
  end
end
