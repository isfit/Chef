class MealType < ActiveRecord::Base
  attr_accessible :title
  has_many :meals
  has_many :orders, through: :meals

  def amount_ordered_for_day(date)
    o = Order.to_be_delivered_on(date)
    meals.where(order_id: o).sum(:amount)
  end

  def amount_ordered_for_day_by_location(date,location)
    o = Order.to_be_delivered_on(date)
    o2 = []
    o.each do |order|
      if order.location.name == location
        o2 << order
      end
    end
    meals.where(order_id: o2).sum(:amount)
  end
  def amount_sum
    meals.sum(:amount)
  end
end
