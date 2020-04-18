class Tasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description
      t.integer :status, null: false, default: 0
      t.datetime :schedule_date
      t.integer :responsable_id
      t.references :list, foreign_key: true

      t.timestamps null: false
    end
  end
end
