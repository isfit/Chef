class User < ActiveRecord::Base
  attr_accessor :username, :workshop 

  has_many :orders

  has_secure_password
end
