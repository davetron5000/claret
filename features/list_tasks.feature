Feature: I can list tasks
  In order to keep track of things to do
  I need to be able to see what the tasks are

  Scenario: List tasks
    Given there are three tasks in the task list
    When I successfully run `claret ls`
    Then the output should show the three tasks

  Scenario: List tasks is OK with there not being a task list
    Given there is no task list
    When I run `claret ls`
    Then the exit status should be 0

  Scenario: List all tasks, including completed ones
    Given there are three tasks in the task list
    And one of them is completed
    When I successfully run `claret ls all`
    Then the output should show the three tasks
    And the completed task should be highlighted with the completion date

    @wip
  Scenario: List in-progress tasks,
    Given there are three tasks in the task list
    And one of them has been started
    And another one of them has been completed
    When I successfully run `claret ls wip`
    Then the output should show the started task only
