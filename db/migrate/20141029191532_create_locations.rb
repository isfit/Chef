class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.text :address

      t.timestamps
    end
    add_column :orders, :location_id, :integer
  end
end
