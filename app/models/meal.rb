class Meal < ActiveRecord::Base
  attr_accessible :meal_type_id, :amount
  validates :amount, :numericality => true

  belongs_to :meal_type
  belongs_to :order
end
