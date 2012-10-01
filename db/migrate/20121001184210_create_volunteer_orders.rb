class CreateVolunteerOrders < ActiveRecord::Migration
  def change
    create_table :orders_volunteers do |t|
      t.integer :volunteer_id
      t.integer :order_id
    end
  end
end
