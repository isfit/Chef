class User < ActiveRecord::Base
  has_many :orders

  has_many :groups, :through => :positions
  has_and_belongs_to_many :positions

  has_secure_password
end
