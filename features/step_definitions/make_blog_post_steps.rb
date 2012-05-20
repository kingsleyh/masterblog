When /^I make a new blog post$/ do
  find('#new_article').visible?
  find('#new_article').click
  find_button('Create Article')
  fill_in('article[title]', :with => 'A Great Article')
  fill_in('article[excerpt]', :with => 'This is the excerpt')
  fill_in('article[content]', :with => 'This is the content')
  fill_in('article[tags]', :with => 'ruby')
  click_button('Create Article')
end

Then /^the article is created$/ do
  !Article.find_by_title('A Great Article').nil?
end

Then /^listed on the admin articles page:$/ do |table|
  find('.box-head').find('h2').has_content?("Articles")
  actual_data = table.rows_hash
  expected_data = {"title" => "A Great Article", "name" => "foo"}
  assert_equal(expected_data, actual_data, "Article was not listed")
end