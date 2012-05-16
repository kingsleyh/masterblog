Given /^no users exist$/ do

end

When /^I login$/ do
 visit('/admin')
end

Then /^I should be asked to create a new user$/ do
  page.should have_selector('#first-user-message')
end