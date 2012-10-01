class Volunteer < ActiveRecord::Base
  attr_accessible :username, :orders
  has_and_belongs_to_many :orders
end
