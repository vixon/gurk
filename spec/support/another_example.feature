Feature: About Page

  Scenario:
    Given I have a page called 'About'
    And it has a title called 'about'
    And it has a route of '/about'
    When I visit '/about'
    Then I should see 'about'
