class AddDisplayNameAndUserNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :display_name, :string
    add_column :users, :user_name, :string
  end
end
