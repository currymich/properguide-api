class AddPatientNameColumnToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :patient_name, :string
  end
end
