class Meal < ActiveRecord::Base
  attr_accessible :meal_type_id, :amount

  belongs_to :meal_type
  belongs_to :order
end
