Feature: Home Page

  Scenario: Lalala
    Given I have a page called 'Home'
    And it has a title called 'home'
    And it has a route of '/'
    When I visit '/'
    Then I should see 'home'
