class MealType < ActiveRecord::Base
  attr_accessible :title
  has_many :meals
  has_many :orders, through: :meals

  def self.available_at(date)
    self.where("available_from < ? and available_to > ?", date, date )
  end

  def available?(date)
    date > available_from && date < available_to
  end

end
