Given /^no users exist$/ do

end

When /^I try to login$/ do
 visit('/admin')
 find_link('Facebook').visible?
 click_link('Facebook')
end

Then /^I should be asked to create a new user with the following credentials:$/ do |table|
  actual_data = table.rows_hash
  expected_data = {"provider"=>"facebook", "name"=>"foo", "email"=>"foobar@example.com"}
  assert_equal(expected_data,actual_data,"facebook account data does not match")
end

When /^I create the first user$/ do
  visit('/admin')
  find_link('Facebook').click
  find_button('Confirm and create new account').click
end

Then /^the user should be created$/ do
  find("#flash").find("div").has_content?("Your account has been created and you have been signed in!")
end

Then /^I should be logged in$/ do
  find("#nav_user").find("ul").find("span").has_content?("foobar@example.com")
end


Given /^a user already exists$/ do
  User.create(:name => 'test_user', :email => "test@example.com")
end

Then /^I should be redirected to the home page$/ do
  find('#home_page').has_content?("Home Page")
end

Given /^I already have an account$/ do
  user = User.create(:name => 'foo', :email => "foobar@example.com")
  user.services << Service.create(:provider => 'facebook',:uid => '123', :uname => 'foo', :uemail => 'foobar@example.com')
end