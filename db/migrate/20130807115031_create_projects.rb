class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :g_id
      t.string :name
      t.text :description
      t.string :url
      t.string :homepage
      t.integer :forks_count
      t.integer :watchers_count
      t.integer :open_issues_count
      t.datetime :g_updated_at
      t.references :user

      t.timestamps
    end
    add_index :projects, :user_id
  end
end
