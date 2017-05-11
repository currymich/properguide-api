class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.references :user, foreign_key: true
      t.string :subject
      t.string :text

      t.timestamps
    end
  end
end
