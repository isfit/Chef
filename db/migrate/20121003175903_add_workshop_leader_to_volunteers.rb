class AddWorkshopLeaderToVolunteers < ActiveRecord::Migration
  def change
    add_column :volunteers, :workshop_leader, :boolean
  end
end
