Chef::Application.routes.draw do
  resources :orders
  resources :sessions
  namespace :admin do
    resources :orders
    resources :meal_types
  end
  
  match 'login' => 'sessions#new'
  match 'logout' => 'sessions#destroy'

  match 'new_mass_order' => 'orders#new_mass_order'
  match 'create_mass_order' => 'orders#create_mass_order'

  root :to => 'orders#index'
end
