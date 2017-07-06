class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.references :orders, foreign_key: true
      t.integer :amount
      t.string :description

      t.timestamps
    end
  end
end
