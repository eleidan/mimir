@help
Feature: help command

  As a user of the application I want to get
  information about particular command by specifying
  command name as an agrument for the help command.

    Scenario Outline: issue command
      When I run <command>
      Then I get particular first line of the result <output>

      Scenarios: help command with options
        | command                 | output                                    |
        | mimir help              | Usage:                                    |
        | mimir help --help       | Print information about the command use   |
        | mimir help dump         | Get list of all objects in provided class |
