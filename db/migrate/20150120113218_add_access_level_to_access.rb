class AddAccessLevelToAccess < ActiveRecord::Migration
  def change
    add_column :accesses, :access_level, :integer
  end
end
