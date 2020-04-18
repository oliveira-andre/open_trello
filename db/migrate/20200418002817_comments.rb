class Comments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :description, null: false
      t.references :task, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps null: false
    end
  end
end
