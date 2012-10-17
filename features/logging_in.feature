Feature: Logging in to the system
  In order for everyone to gain access to the appropriate parts of the system
  I want to log in to Chef with my Internal-credentials
  So that I can perform the tasks I want to

  Scenario: Logging in as a volunteer
    Given I am a registered volunteer with username "placeholdersen" and password "kake"
    When I go to the login page
    And I fill in Username with "placeholdersen" and Password with "kake"
    And I press "Login"
    Then I should see "Successfully logged in as a volunteer"
