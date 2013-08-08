TerasologyMods::Application.routes.draw do
  resources :projects do
  	get 'import/:username/:name', to: 'projects#import', :on => :collection, :as => :import_repo
  end

  match 'recent' => 'projects#recent', :as => :recent
  match 'updated' => 'projects#updated', :as => :updated

  match 'categories/:category_id', to: 'projects#category', :as => :category

  devise_for :users
  resources :users

  match '/users/auth/:service/callback' => 'services#create' 
  resources :services, :only => [:index, :create, :destroy]

  root :to => 'projects#index'
end
