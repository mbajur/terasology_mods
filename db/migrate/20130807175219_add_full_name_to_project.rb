class AddFullNameToProject < ActiveRecord::Migration
  def change
    add_column :projects, :full_name, :string
    change_column :projects, :g_id, :integer, :unique => true
  end
end
