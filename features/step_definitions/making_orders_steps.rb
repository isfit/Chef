Given /^I am logged in as a voulenteer$/ do
  v = Volunteer.new({username:"user"})
  v.save
end

Given /^I have not ordered any food$/ do
  Volunteer.first.orders.count.should be 0
end

Then /^I should see only meals available for delivery at my chosen time$/ do

end
