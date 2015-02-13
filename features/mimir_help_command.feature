@help
Feature: help command

  As a user of the application I want to get
  information about particular command by specifying
  command name as an agrument for the help command.

    Scenario Outline: help command does the same as
      When I run <command>
      Then the <output> should be the same as for <help command>

      Scenarios: help command with options
        | command                 | output                                    |
        | mimir help              | Usage:                                    |
        | mimir help --help       | Print information about the command use   |
        | mimir help dump         | Get list of all objects in provided class |
