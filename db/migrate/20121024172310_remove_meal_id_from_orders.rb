class RemoveMealIdFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :meal_id
  end
end
