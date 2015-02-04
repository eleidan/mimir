Feature: Command Line Interface

  As a user of the application I want to issue commands
  with CLI and get results.

    Scenario: Get help on how to use the application
      When I run `mimir`
      Then I should get output of usage.

    Scenario: Get version of the application
      When I run `mimir --version`
      Then I should get output of the version.

    Scenario: Get dump for a class
      When I run `mimir dump String`
      Then I should get output of the list of methods "String" class.
