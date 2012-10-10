class DropVolunteer < ActiveRecord::Migration
  def change
    drop_table :volunteers
  end
end
