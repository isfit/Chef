Feature: Ordering lunches as a voulenteer not in a workshop
  In order to feed my hunger when working late
  I want to order lunch for myself and my company
  And have it delivered at a specific time and place
  So that we are fed and can concentrate

  Scenario: Place an order for one of the available meals
    Given I am logged in as a volunteer
    And there is a meal named "Kake" available on "2012-02-13"
    And I have not ordered any food
    When I place an order for "Kake" to be delivered at "2012-02-13"
    Then I should have one order registered for delivery at "2012-02-13" for the meal named "Kake"
