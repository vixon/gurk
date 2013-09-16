Feature: My site

  Scenario: Home Page
    Given I have a page called 'Home'
    And it has a title called 'home'
    And it has a route of '/'
    When I visit '/'
    Then I should see 'home'

  Scenario: About
    Given I have a page called 'About'
    And it has a title called 'About Us'
    And it has a route of '/about'
    When I visit '/about'
    Then I should see 'About Us'
