class Tags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :description, null: false
      t.integer :color, null: false, default: 0
      t.references :task, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
