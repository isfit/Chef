Chef::Application.routes.draw do
  resources :orders
  resources :sessions
  resources :meals
end
