require 'spec_helper'

describe Order do
  it "should bind a meal to a delivery-time" do
    m = Meal.new({title:"Halla"})
    m.save
    o = Order.new({delivered_at:Time.now, meal:m})
    o.save
    o.meal.title.should eq("Halla")
  end

  it "should be filterable by delivery date" do
    m = Meal.new({title:"Halla"})
    m.save
    o1 = Order.new({delivered_at:Time.parse("Feb 2 2012"), meal:m})
    o1.save
    o2 = Order.new({delivered_at:Time.parse("Feb 3 2012"), meal:m})
    o2.save
    o3 = Order.new({delivered_at:Time.parse("Feb 1 2012"), meal:m})
    o3.save
    
    os = Order.to_be_delivered_on(Date.parse("Feb 2 2012"))

    os.count.should eq(1)
  end
end
