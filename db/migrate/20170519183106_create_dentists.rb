class CreateDentists < ActiveRecord::Migration[5.0]
  def change
    create_table :dentists do |t|
      t.string :name
      t.string :office_name
      t.string :email
      t.string :phone
      t.string :address
      t.string :address_state
      t.string :address_zip
      t.string :address_city
      t.string :license_num

      t.timestamps
    end
  end
end
