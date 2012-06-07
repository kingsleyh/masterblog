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
  ed = table.rows_hash
  find('#0_title').has_content?(ed[:title])
  find('#0_name').has_content?(ed[:name])
end

Given /^I have made a blog post$/ do
  Article.create(:title => "A Great Article", :user_id => 1, :tags => "ruby", :excerpt => "An Excerpt", :content => "Some Content")
  visit('/admin')
end

When /^I edit the article$/ do
  find('#0_title').visible?
  find('#0_title').find('a').click
  find_button('Update Article')
   fill_in('article[title]', :with => 'A Great Article again')
  click_button('Update Article')
end

Then /^the changes are visible on the admin articles page:$/ do |table|
  find('.box-head').find('h2').has_content?("Articles")
  ed = table.rows_hash
  find('#0_title').has_content?(ed[:title])
end