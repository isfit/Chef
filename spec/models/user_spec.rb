require 'spec_helper'

describe User do
  it "should be possible to save a user with a good username and password" do
    u = User.new
    u.username="usernam"
    u.password="pass"
    u.password_confirmation="pass"
    u.save

    User.count.should eql 1
    u.authenticate("pass").should_not be nil
  end

  it "should be able to list all belonging orders" do
    o = Order.new
    o.save

    v = User.new
    v.username="FU"
    v.password = "pass"
    v.password_confirmation = "pass"
    v.orders << o
    v.save
    
    v.orders.count.should be 1
  end
end
