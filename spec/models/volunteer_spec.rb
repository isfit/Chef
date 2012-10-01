require 'spec_helper'

describe Volunteer do
  it "should be able to list all belonging orders" do
    o = Order.new
    o.save

    v = Volunteer.new({username:"FU", orders:[o]})
    v.save
    
    v.orders.count.should be 1
  end
end
