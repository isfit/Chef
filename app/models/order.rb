class Order < ActiveRecord::Base
  attr_accessible :delivered_at, :meal_id, :meal
  belongs_to :meal
  has_and_belongs_to_many :volunteers

  def self.to_be_delivered_at(time)
  end
end
