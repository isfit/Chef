class RemoveAvailableAt < ActiveRecord::Migration
  def change
    remove_column :meals, :available_from
    remove_column :meals, :available_to
  end
end
