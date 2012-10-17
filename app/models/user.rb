class User < ActiveRecord::Base
  attr_accessor :username, :workshop 

  has_and_belongs_to_many :orders

  has_secure_password
end
