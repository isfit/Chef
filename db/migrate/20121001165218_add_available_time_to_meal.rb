class AddAvailableTimeToMeal < ActiveRecord::Migration
  def change
    add_column :meals, :available_from, :datetime
    add_column :meals, :available_to, :datetime
  end
end
