class Project < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :forks_count, :g_id, :g_updated_at, :homepage, 
  				  :name, :open_issues_count, :url, :watchers_count, :category_list

  validates :g_id, uniqueness: { message: 'This repository has allready been imported to Terasology Mods.' }
  validates :name, presence: true
  validates :category_list, presence: { message: 'Please pick at least one category.' }

  acts_as_taggable_on :categories
end
