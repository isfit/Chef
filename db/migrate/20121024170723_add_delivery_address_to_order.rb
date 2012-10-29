class AddDeliveryAddressToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :deliver_to, :string
  end
end
