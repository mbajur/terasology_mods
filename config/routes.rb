TerasologyMods::Application.routes.draw do
  resources :projects


  devise_for :users

  match '/users/auth/:service/callback' => 'services#create' 
  resources :services, :only => [:index, :create, :destroy]

  root :to => 'application#index'
end
