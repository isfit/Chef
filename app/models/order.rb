class Order < ActiveRecord::Base
  attr_accessible :delivered_at, :meal_id, :meal, :amount
  belongs_to :meal
  has_and_belongs_to_many :volunteers

  def self.to_be_delivered_on(date)
    self.where("delivered_at >= ? AND delivered_at <= ?", date, date+1)
  end
end
