Feature: Command Line Interface

  As a user of the application I want to issue commands
  with CLI and get results.

    @help
    Scenario Outline: help command does the same as
      When I run <command>
      Then the <output> should be the same as for <help command>

      Scenarios: help command with options
        | command                         | output                            |
        | mimir help              | Usage:                                    |
        | mimir help --help       | Print information about the command use   |
        | mimir help dump         | Get list of all objects in provided class |
