Given /^no users exist$/ do

end

When /^I try to login$/ do
  login
end

Given /^I have logged in$/ do
  create_account
  login
  find("#usr-name").has_content?("foo")
end

Then /^I should be asked to create a new user with the following credentials:$/ do |table|
  actual_data = table.rows_hash
  expected_data = {"provider" => "facebook", "name" => "foo", "email" => "foobar@example.com"}
  assert_equal(expected_data, actual_data, "facebook account data does not match")
end

When /^I create the first user$/ do
  visit('/admin')
    find_link('Facebook').click
    find_button('Confirm and create new account').click
end

Then /^the user should be created$/ do
  find(".ad-notif-success").find("p").has_content?("Your account has been created and you have been signed in!")
  !User.find_by_email("foobar@example.com").nil?
end

Then /^I should be logged in$/ do
  find("#usr-name").has_content?("foo")
end

Given /^a user already exists$/ do
  User.create(:name => 'test_user', :email => "test@example.com")
end

Then /^I should be redirected to the login page$/ do
  find('.logo').find('h1').has_content?("LOGIN PAGE")
end

Given /^I already have an account$/ do
  create_account
end

private

def login
  visit('/admin')
  find_link('Facebook').click
end

def create_account
  user = User.create(:name => 'foo', :email => "foobar@example.com")
  user.services << Service.create(:provider => 'facebook', :uid => '123', :uname => 'foo', :uemail => 'foobar@example.com')
end

