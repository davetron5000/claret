Feature: I can complete tasks
  In order to keep track of things to do
  I need to be able to mark tasks as done

  Scenario: Complete a task
    Given there are three tasks in the task list
    When I successfully run `claret task done 1`
    Then the second task should not show up by default

  Scenario: Complete a task twice generates an error
    Given there are three tasks in the task list
    Given I successfully run `claret task done 1`
    When I run `claret task done 1`
    Then the exit status should not be 0
    And the stderr should contain "Task 1 is already complete"

  Scenario: Complete a non-existent task generates an error
    Given there are three tasks in the task list
    When I run `claret task done 4`
    Then the exit status should not be 0
    And the stderr should contain "No task with id 4"

  Scenario: Missing the index generates error and help
    Given there are three tasks in the task list
    When I run `claret task done`
    Then the exit status should not be 0
    And the stderr should contain "task_id is required"
    And the help should be printed for "done"
