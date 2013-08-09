class Project < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :forks_count, :g_id, :g_updated_at, :homepage, 
  				  :name, :open_issues_count, :url, :watchers_count, :category_list

  validates :g_id, uniqueness: { message: 'This repository has already been imported to Terasology Mods.' }
  validates :name, presence: true
  validates :category_list, presence: { message: 'Please pick at least one category.' }, :on => :update

  acts_as_taggable_on :categories
  acts_as_indexed :fields => [:name, :description]

  # Gets similar projects based on
  # categories this project is assigned to.
  def find_similar
  	categories = self.category_list
  	Project.tagged_with(categories, :match_all => true).limit(5)
  end

  def find_other_from_user(user = nil)
  	user ||= self.user
  	user.projects.order('watchers_count DESC').limit(5)
  end
end
