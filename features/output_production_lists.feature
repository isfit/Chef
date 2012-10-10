Feature: Output and print production lists for each day
  In order to produce the correct amount of food
  As a production line manager
  I want to print a list of meals to produce for a specific day
  So that we don't over- or under-produce food

  Scenario: Show an overview of the orders for today
    Given there are 10 orders for a meal named "Kake, glutenfri" for "2013-01-12" 
    And there are 5 orders for a meal named "Kake, sukkerfri (aesj)" for "2013-01-12" 
    And there are 3 orders for a meal named "Kake" for "2013-01-12" 
    When I go to show orders
    And I select "2012-01-12"
    Then I should see 10 orders for "Kake, glutenfri"
    And I should see 5 orders for "Kake, sukkerfri (aesj)"
    And I should see 3 orders for "Kake"
