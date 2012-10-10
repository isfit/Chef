Feature: Making orders on behalf of a workshop
  In order to feed my entire workshop
  As a workshop leader
  I want to create large orders for all the days of my workshop

  Scenario: Create a single large order for a single day
    Given I am a Workshop-leader
    And there is a meal named "Kake" available on "2012-02-13"
    When I place an order for 50 meals named "Kake" to be delivered at "2012-02-13"
    Then there should be an order for 50 meals named "Kake" to be delivered at "2012-02-13"

  Scenario: Create a diverse order, consisting of different meals
    Given I am a Workshop-leader
    And there is a meal named "Kake" available on "2012-02-13" with allergy "Hallal"
    And there is a meal named "Kake" available on "2012-02-13" with allergy "None"
    When I place an order for 25 meals named "Kake" to be delivered at "2012-02-13"


