class AddDefaultToTask < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :title, :string, default: ''
  end
end
