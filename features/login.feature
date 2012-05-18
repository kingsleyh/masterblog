Feature: login
  As a blogger
  I want to log in to my blog
  So that I can make blog posts

  Scenario: instruct creation of new user when no users exist
    Given no users exist
    When I login
    Then I should be asked to create a new user with the following credentials:
    |provider|facebook          |
    |name    |foo               |
    |email   |foobar@example.com|

  Scenario: create first user
    Given no users exist
    When I create the first user
    Then the user should be created
    And I should be logged in
