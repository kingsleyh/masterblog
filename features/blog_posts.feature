Feature: Create,Edit and Delete Blog posts
  As an avid blogger
  I want to create,edit and delete blog posts
  So that I can share my wisdom with the world

  Scenario: Make a new blog post
    Given I have logged in
    When I make a new blog post
    Then the article is created
    And listed on the admin articles page:
      | title | A Great Article |
      | name  | foo             |

  Scenario: Edit an existing blog post
    Given I have logged in
    And I have made a blog post
    When I edit the article
    Then the changes are visible on the admin articles page:
      | title | Edited Article Title |
