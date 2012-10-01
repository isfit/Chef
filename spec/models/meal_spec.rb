require 'spec_helper'

describe Meal do
  it "should be instantiable" do
    m = Meal.new({title:'fredagslonsj'})
    m.title.should eq('fredagslonsj')
    m.save
    Meal.all.count.should be(1)
  end

  it "should only be available in given timeslots" do
    m = Meal.new({title:'Fancy meal', available_from:Time.utc("2012", "feb",1,20,15,1), available_to:Time.utc("2012", "feb",2,20,15,1)})
    m.save

    time_that_is_available = Time.parse("Feb 2 2012")
    time_that_is_not_available = Time.parse("Feb 5 2012")
    m.available?(time_that_is_not_available).should be(false)
  end

  it "should only give me meals available at a chosen time" do
    time = Time.parse("2012-02-14")
    m = Meal.new({title:'Fancy meal', available_from:Time.parse("2012-02-12"), available_to:Time.parse("2012-02-16")})
    m.save

    m2 = Meal.new({title:'Fancy meal', available_from:Time.parse("2012-3-12"), available_to:Time.parse("2012-3-16")})
    m2.save

    Meal.available_at(time).count.should be 1
  end
end
