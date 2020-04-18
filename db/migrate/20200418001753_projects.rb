class Projects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.integer :status, null: false, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
