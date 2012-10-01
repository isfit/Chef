Given /^there are no meals$/ do
  Meal.count.should be 0
end

Then /^there should be (\d+) meals$/ do |arg1|
  Meal.count.should eq arg1.to_i
end

When /^I register a new meal$/ do
  m = Meal.new
  m.save
end

When /^I register a new meal available from "(.*?)" to "(.*?)"$/ do |arg1, arg2|
  m = Meal.new({available_from:Time.parse(arg1), available_to:Time.parse(arg2)})
  m.save
end

Then /^there should be (\d+) meals available on "(.*?)"$/ do |arg1, arg2|
  pending
end

Then /^only the last meal created should be available on "(.*?)"$/ do |arg1|
  Meal.last.available?(Time.parse(arg1)).should be true
  Meal.first.available?(Time.parse(arg1)).should be false
end
