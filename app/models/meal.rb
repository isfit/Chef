class Meal < ActiveRecord::Base
  attr_accessible :title, :available_from, :available_to
  has_many :orders

  def self.available_at(date)
    self.where("available_from < ? and available_to > ?", date, date )
  end

  def available?(date)
    date > available_from && date < available_to
  end

end
