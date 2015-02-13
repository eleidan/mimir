Feature: dump command

  As a user of the application I want to get
  information about particular class by specifying
  class name as an agrument for the dump command.

    @dump 
    Scenario Outline: issue command
      When I run <command>
      Then I get particular first line of the result <output>

      Scenarios: dump command without options, or with option --help
        | command              | output                                       |
        | mimir dump           | Usage:                                       |
        | mimir dump --help    | Get list of all objects in provided class    |

      Scenarios: dump command with options
        | command                         | output                            |
        | mimir dump Hash -fjson          | {"Hash":                          |
        | mimir dump Hash -fjson --pretty |  "Hash": {                        |
