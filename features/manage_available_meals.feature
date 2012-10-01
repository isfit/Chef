Feature: Managing available meal-choices
  In order for attendees to order meals
  As an administrator
  I want to create detailed description of meals to choose from

  Scenario: New meal
    Given there are no meals
    When I register a new meal
    Then there should be 1 meals

  Scenario: Create a meal with limited availability
    Given there are no meals
    When I register a new meal available from "2012-01-10" to "2012-01-12"
    And I register a new meal available from "2012-02-13" to "2012-02-15"
    Then only the last meal created should be available on "2012-02-14"
