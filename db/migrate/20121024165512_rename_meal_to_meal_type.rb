class RenameMealToMealType < ActiveRecord::Migration
  def change
    rename_table :meals, :meal_types
  end
end
