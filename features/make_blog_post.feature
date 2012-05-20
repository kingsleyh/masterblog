Feature: Make a new blog post
  As a blogger
  I want to make a new blog post
  In order to share my wisdom with the world

  Scenario: Make a new blog post
    Given I have logged in
    When I make a new blog post
    Then the article is created
    And listed on the admin articles page:
    |title|A Great Article|
    |name |foo|