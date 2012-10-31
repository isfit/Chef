Chef::Application.routes.draw do
  resources :orders
  resources :sessions
  resources :meal_types
  match 'login' => 'sessions#new'

  match 'admin/index' => 'admin#index'
  match 'admin/orders' => 'admin#orders'
  match 'admin/output_orders' => 'admin#output_orders'

  root :to => 'orders#index'
end
