class AddDentistToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :dentist, index: true
  end
end
