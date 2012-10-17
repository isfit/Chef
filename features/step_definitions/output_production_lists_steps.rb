Given /^there are (\d+) orders for a meal named "(.*?)" for "(.*?)"$/ do |arg1, arg2, arg3|
  m = Meal.new({title:arg2})
  m.save
  o = Order.new({meal:m, delivered_at: Date.parse(arg3), amount:arg1.to_i})
  o.save
end

When /^I go to show orders$/ do
  visit(orders_path)
end

When /^I select "(.*?)"$/ do |arg1|
  pending
  page.select(arg1, :from => "date")
end

Then /^I should see (\d+) orders for "(.*?)"$/ do |arg1, arg2|
  
  page.all('table#orders tr').count.should == 3
end
