class Lists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists do |t|
      t.string :title, null: false
      t.integer :status, default: 0
      t.references :project, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
