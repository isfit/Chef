Chef::Application.routes.draw do
  resources :orders do |o|
  end
  resources :sessions
  resources :meal_types
  match 'login' => 'sessions#new'
  match 'logout' => 'sessions#destroy'

  match 'admin/index' => 'admin#index'
  match 'admin/orders' => 'admin#orders'
  match 'admin/output_orders' => 'admin#output_orders'
  match 'new_mass_order' => 'orders#new_mass_order'
  match 'create_mass_order' => 'orders#create_mass_order'

  root :to => 'orders#index'
end
