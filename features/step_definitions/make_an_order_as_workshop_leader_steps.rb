Given /^I am a Workshop\-leader$/ do
  v = User.new({workshop_leader:true})
  v.save
end

When /^I place an order for (\d+) meals named "(.*?)" to be delivered at "(.*?)"$/ do |arg1, arg2, arg3|
  pending # express the regexp above with the code you wish you had
end

Then /^there should be an order for (\d+) meals named "(.*?)" to be delivered at "(.*?)"$/ do |arg1, arg2, arg3|
  pending # express the regexp above with the code you wish you had
end
