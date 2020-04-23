class AddDefaultToTitleLists < ActiveRecord::Migration[6.0]
  def change
    change_column :lists, :title, :string, default: ''
  end
end
