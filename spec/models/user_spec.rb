require 'spec_helper'

describe User do
  it "should be able to list all belonging orders" do
    o = Order.new
    o.save

    v = User.new({username:"FU", orders:[o]})
    v.save
    
    v.orders.count.should be 1
  end

  it "should distinguish workshop leaders" do
    v = User.new({username:"leada", workshop_leader:true})
    v.save

    v_no = User.new({username:"no_lead", workshop_leader:false})
    v_no.save

    v.workshop_leader.should be true
    v_no.workshop_leader.should be false
  end
end
