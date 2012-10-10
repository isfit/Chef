Given /^I have not ordered any food$/ do
  Volunteer.first.orders.count.should be 0
end

Given /^I am logged in as a volunteer$/ do
  v = Volunteer.new({username:"user"})
  v.save
end

Given /^there is a meal named "(.*?)" available on "(.*?)"$/ do |arg1, arg2|
  m = Meal.new({title:arg1, available_from:Date.parse(arg2), available_to:Date.parse(arg2)+1})
  m.save
end

When /^I place an order for "(.*?)" to be delivered at "(.*?)"$/ do |arg1, arg2|
  m = Meal.find_by_title(arg1)
  v = Volunteer.last
  o = Order.new({delivered_at:Date.parse(arg2)})
  o.meal = m
  o.save
  v.orders << o
  v.save
end

Then /^I should have one order registered for delivery at "(.*?)" for the meal named "(.*?)"$/ do |arg1, arg2|
  v = Volunteer.last
  v.orders.count.should be 1

  v.orders.last.meal.title.should eq arg2
end

