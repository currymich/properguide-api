class AddColumnsQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :phone, :string
    add_column :questions, :email, :string
    add_column :questions, :name, :string
  end
end
