class Order < ActiveRecord::Base
  attr_accessible :delivered_at, :meals_attributes, :amount, :deliver_to, :comment
  has_many :meals
  has_many :meal_types, through: :meals
  belongs_to :user
  accepts_nested_attributes_for :meals

  validates_date :delivered_at, :on => :create, :after => :today

  def self.to_be_delivered_on(date)
    self.where("delivered_at >= ? AND delivered_at <= ?", date, date+1)
  end

  def total_order_amount
    meals.sum(:amount)
  end

end
