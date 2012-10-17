Given /^I am a registered volunteer with username "(.*?)" and password "(.*?)"$/ do |arg1, arg2|
  u = User.new
  u.username = arg1
  u.password=arg2
  u.password_confirmation=arg2
  u.save
end

When /^I go to the login page$/ do
  visit(new_session_path)
end

When /^I fill in Username with "(.*?)" and Password with "(.*?)"$/ do |arg1, arg2|
    fill_in 'Username', :with => arg1
    fill_in 'Password', :with => arg2
    fill_in 'Password Confirmation', :with => arg2
end

When /^I press "(.*?)"$/ do |arg1|
  click_button arg1
end

Then /^I should see "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
