class Project < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :forks_count, :g_id, :g_updated_at, :homepage, :name, :open_issues_count, :url, :watchers_count
end
