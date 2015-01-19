class Order < ActiveRecord::Base
  attr_accessible :delivered_at, :meals_attributes, :amount, :deliver_to, :comment, :location_id, :workshop_name
  has_many :meals
  has_many :meal_types, through: :meals
  belongs_to :location
  belongs_to :user
  accepts_nested_attributes_for :meals
  validates_presence_of :delivered_at, :message => "can't be empty"



  def self.to_be_delivered_on(date)
    self.where("delivered_at >= ? AND delivered_at <= ?", date, date+1)
  end

  def total_order_amount
    meals.sum(:amount)
  end

  def self.orders_by_location(location_id)
    self.where("location_id = ?",location_id)
  end

end
