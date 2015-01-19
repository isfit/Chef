class AddWorkshopNameToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :workshop_name, :string
  end
end
