Feature: Command Line Interface

  As a user of the application I want to issue commands
  with CLI and get results.

    Scenario: Execute the application without any arguments
      When I run `mimir`
      Then the output should contain "Introspection utility for Ruby language"

    Scenario: Get help on how to use the application
      When I run `mimir --help`
      Then the output should contain "Introspection utility for Ruby language"

    Scenario: Get version of the application
      When I run `mimir --version`
      Then the output `mimir --version` should give the current application version

    @announce
    Scenario: Issue "help" command without any arguments
      When I run `mimir help`
      Then the output should contain "Usage:"

    Scenario: Issue "dump" command with 'String' class
      When I run `mimir dump String`
      Then I should get output of the list of methods "String" class
