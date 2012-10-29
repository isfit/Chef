class CreateMealsHmt < ActiveRecord::Migration
  def change
    create_table "meals", :force => true do |t|
      t.integer   "amount"
      t.integer "meal_type_id"
      t.integer "order_id"
    end
  end
end
