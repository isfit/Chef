class RenameVolunteerOrders < ActiveRecord::Migration
  def change
    rename_table :orders_volunteers, :orders_users
  end
end
