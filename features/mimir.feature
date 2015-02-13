Feature: Command Line Interface

  As a user of the application I want to issue commands
  with CLI and get results.

    @mimir
    Scenario Outline: run application
      When I run <command>
      Then I get particular first line of the result <output>

      Scenarios: commands that print help or usage
        | command                 | output                                    |
        | mimir                   | Introspection utility for Ruby language   |
        | mimir --help            | Introspection utility for Ruby language   |
        | mimir --version         | 0.0.1                                     |
