Feature: login
  As an avid blogger
  I want to log in to my blog
  So that I can make blog posts

  Scenario: instruct creation of new user when no users exist
    Given no users exist
    When I try to login
    Then I should be asked to create a new user with the following credentials:
    |provider|facebook          |
    |name    |foo               |
    |email   |foobar@example.com|

  Scenario: create first user
    Given no users exist
    When I create the first user
    Then the user should be created
    And I should be logged in

  Scenario: when a user already exists prevent anonymous user creation
    Given a user already exists
    When I try to login
    Then I should be redirected to the login page

  Scenario: login with existing account
    Given I already have an account
    When I try to login
    Then I should be logged in



