Feature: Ordering lunches as a voulenteer not in a workshop
  In order to feed my hunger when working late
  I want to order lunch for myself and my company
  And have it delivered at a specific time and place
  So that we are fed

  Scenario: See available meals to order
    Given I am logged in as a voulenteer
    And I have not ordered any food
    Then I should see only meals available for delivery at my chosen time

