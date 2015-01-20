class CreateAccesses < ActiveRecord::Migration
  def change
    create_table :accesses do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
