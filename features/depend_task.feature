Feature: I can make tasks depend on each other
  In order to model dependencies between things
  I want to specify that one task cannot be completed until another is

  Scenario: Make a dependency
    Given there are three tasks in the task list
    When I successfully run `claret task depend 1 2`
    And I successfully run `claret ls`
    Then the output should indicate that task 1 depends on task 2

  Scenario: Break a dependency
    Given there are three tasks in the task list
    When I successfully run `claret task depend 1 2`
    And I successfully run `claret task undepend 1 2`
    And I successfully run `claret ls`
    Then the output should indicate that task 1 doesn't depend on task 2

